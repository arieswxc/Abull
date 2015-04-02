class CsvFile < ActiveRecord::Base
  # belongs_to :imageable, polymorphic: true
  belongs_to :data_file, polymorphic: true
  mount_uploader :file, CsvUploader
end
