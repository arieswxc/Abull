class Photo < ActiveRecord::Base
  validates :photo, presence: true
  validates :title, presence: true
  validates :title, uniqueness: {scope: :user_id}
  belongs_to :user
  mount_uploader :photo, PhotoUploader
end
