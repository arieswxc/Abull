class AddPicToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address_photo, :string
    add_column :users, :education_photo, :string
  end
end
