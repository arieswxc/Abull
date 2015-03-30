class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:authentication_keys => [:cell]
  validates :password, format: { with: /(?=.*[a-z])(?=.*\d)/i}, :on => :create
  validates :cell, presence: true
  validates :cell, uniqueness: true
  mount_uploader :avatar, AvatarUploader
  mount_uploader :line_csv, LineCsvUploader
  mount_uploader :verify_file, VerifyFileUploader
  has_many :funds,        dependent: :destroy
  has_many :invests,      dependent: :destroy
  has_many :leverages,    dependent: :destroy
  # has_many :photos,       dependent: :destroy
  has_many :topics,       dependent: :destroy
  has_one :account,       dependent: :destroy
  has_one :bank_card,     dependent: :destroy
  has_many :verify_photos, :class_name => "Photo", as: :imageable, dependent: :destroy
  has_many :identity_photos, :class_name => "Photo", as: :imageable, dependent: :destroy
  
  accepts_nested_attributes_for :verify_photos, allow_destroy: true
  accepts_nested_attributes_for :identity_photos, allow_destroy: true
  # accepts_nested_attributes_for :photos, allow_destroy: true
  
  acts_as_followable
  acts_as_follower

  state_machine :level, :initial => :unverified do
    event :investor_apply do
      transition :unverified => :investor_applied
    end
    event :up_to_inv do
      transition :investor_applied  => :investor
    end

    event :investor_deny do
      transition :investor_applied => :unverified
    end

    event :trader_apply do
      transition :investor => :trader_applied
    end

    event :up_to_td do
      transition :trader_applied => :trader
    end

    event :trader_denied do
      transition :trader_applied => :investor
    end

    event :down_to_inv do 
      transition :trader => :investor
    end

    event :down_to_un do
      transition :investor => :unverified
    end 
  end

  def email_required?
    false
  end

  #虚拟属性
  def age 
    Time.now.to_date.year - self.birthday.year if self.birthday
  end

  #重置密码
  def reset_password(cell)
    password = 'a' + rand(1000000..9999999).to_s
    self.password = password
    self.save
    send_password(cell, password)
  end

  private
    def send_password(cell, account_password)
      uri       = URI.parse("http://222.73.117.158/msg/HttpBatchSendSM")
      msg       = "新的账户密码为#{account_password},请及时登陆摩尔街来修改帐号密码"
      username  = 'jiekou-cs-02'
      password  = 'Tch147256'
    
      res = Net::HTTP.post_form(uri, account: username, pswd: password, mobile: cell, msg: msg, needstatus: true)
      res.body.split[1]
    end

end
