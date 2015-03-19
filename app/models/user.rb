class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :password, format: { with: /(?=.*[a-z])(?=.*\d)/i}, :on => :create
  mount_uploader :avatar, AvatarUploader
  has_many :funds
  has_many :invests
  has_many :leverages
  has_many :photos
  has_many :topics
  has_one :account
  
  accepts_nested_attributes_for :photos, allow_destroy: true
  
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

  #虚拟属性
  def age 
    Time.now.to_date.year - self.birthday.year
  end

end
