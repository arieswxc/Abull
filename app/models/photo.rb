class Photo < ActiveRecord::Base
  validates :photo, presence: true, on: :update
  validates :title, presence: true
  validates :title, uniqueness: {scope: :user_id}
  belongs_to :user
  belongs_to :imageable, polymorphic: true
  mount_uploader :photo, PhotoUploader
end
