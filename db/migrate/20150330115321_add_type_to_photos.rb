class AddTypeToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :photo_type, :string
    remove_column :users, :photo_type
  end
end
