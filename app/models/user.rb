class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :password, format: { with: /(?=.*[a-z])(?=.*\d)/i}
  mount_uploader :avatar, AvatarUploader
  has_many :funds
  has_many :invests
  has_many :leverages
  has_many :photos
  has_many :topics
  
  accepts_nested_attributes_for :photos, allow_destroy: true
  
  acts_as_followable
  acts_as_follower

  state_machine :level, :initial => :pending do
    event :check do
      transition [:pending]  => :checked
    end

    event :deny do
      transition [:pending, :checked] => :denied
    end

    event :confirm do 
      transition [:denied] => :investor
    end
  end

end
