class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  validates :password, format: { with: /(?=.*[a-z])(?=.*\d)/i}
  mount_uploader :avatar, AvatarUploader
  has_many :funds
  has_many :invests

  acts_as_followable
  acts_as_follower
end
