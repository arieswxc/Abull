class AddDuotaiToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :imageable_id, :string
    add_column :photos, :imageable_type, :string
  end
end
