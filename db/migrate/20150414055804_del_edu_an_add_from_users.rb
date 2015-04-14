class DelEduAnAddFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :address_photo, :string
    remove_column :users, :education_photo, :string
  end
end
