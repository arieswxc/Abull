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
    event :up_to_inv do
      transition [:unverified]  => :investor
    end

    event :up_to_td do
      transition [:investor] => :trader
    end

    event :down_to_inv do 
      transition [:trader] => :investor
    end

    event :down_to_un do
      transition [:investor] => :unverified
    end 
  end

end
