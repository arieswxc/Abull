class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include ActiveModel::Dirty 
  before_save :check_email_state

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:authentication_keys => [:cell]
  validates :password, format: { with: /(?=.*[a-z])(?=.*\d)/i}, :on => :create
  validates :cell, presence: true
  validates :cell, uniqueness: true
  validates :username, uniqueness: true
  mount_uploader :avatar, AvatarUploader
  has_many :funds,        dependent: :destroy
  has_many :invests,      dependent: :destroy
  has_many :leverages,    dependent: :destroy
  has_many :topics,       dependent: :destroy
  has_one :account,       dependent: :destroy
  has_one :bank_card,     dependent: :destroy
  has_many :verify_photos, -> { where photo_type: "verify_photo" }, :class_name => "Photo", as: :imageable, dependent: :destroy
  has_many :identity_photos, -> { where photo_type: "identity_photo" }, :class_name => "Photo", as: :imageable, dependent: :destroy
  has_one :address_photo, -> { where photo_type: "address_photo" }, :class_name => "Photo", as: :imageable, dependent: :destroy
  has_one :education_photo, -> { where photo_type: "education_photo" }, :class_name => "Photo", as: :imageable, dependent: :destroy

  has_one :line_csv, :class_name => "CsvFile", as: :data_file, dependent: :destroy

  accepts_nested_attributes_for :verify_photos, allow_destroy: true, :reject_if => proc { |attributes| attributes["photo"].blank? }
  accepts_nested_attributes_for :identity_photos, allow_destroy: true
  accepts_nested_attributes_for :address_photo, allow_destroy: true
  accepts_nested_attributes_for :education_photo, allow_destroy: true
  accepts_nested_attributes_for :line_csv, allow_destroy: true, :reject_if => proc { |attributes| attributes["file"].blank? }

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

  def funds_and_invests_data
    funds_hash = Hash.new(0)
    invests_hash = Hash.new(0)

    if self.funds.any?
      self.funds.each do |fund|
        funds_hash["#{fund.created_at.year}.#{fund.created_at.month}月"] = funds_hash["#{fund.created_at.year}.#{fund.created_at.month}月"] + fund.amount.to_i if fund
      end
    end

    if self.invests.any?
      self.invests.each do |invest|
        invests_hash["#{invest.created_at.year}.#{invest.created_at.month}月"] = invests_hash["#{invest.created_at.year}.#{invest.created_at.month}月"] + invest.amount.to_i if invest
      end
    end

    [funds_hash, invests_hash]
  end

  #重置密码
  def reset_password(password)
    self.password = password
    self.save
  end

  #生成验证码并发送
  def self.generate_verification_code(params, code)
    msg = "尊敬的用户，欢迎加入摩尔街，您的注册验证码是#{code},请尽快完成注册，享受摩尔街完美的投资体验!"
    msg = "您的验证码为#{code}, 请在重置密码页面填写" if params[:forget_pswd].to_i == 1
    batch_code  = send_sms(code, params[:cell], msg)
  end

  def check_email_state
    self.update_column(:active_email, "inactive") if self.email_changed?
  end

private
  def self.send_sms(code, cell, msg)
    uri       = URI.parse("http://222.73.117.158:80/msg/HttpBatchSendSM")
    username  = 'zxnicv'
    password  = 'Txb123456'
    puts "激活码为 #{code}"
    res = Net::HTTP.post_form(uri, account: username, pswd: password, mobile: cell, msg: msg, needstatus: true)
    res.body.split[1]
  end

end
