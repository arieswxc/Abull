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

  acts_as_followable
  acts_as_follower
end
