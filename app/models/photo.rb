class Photo < ActiveRecord::Base
  validates :photo, presence: true, on: :update
  validates :title, :presence => true, :uniqueness => { :scope => [ :imageable_id, :imageable_type ] }
  belongs_to :imageable, polymorphic: true
  mount_uploader :photo, PhotoUploader
end
