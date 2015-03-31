class AddTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :photo_type, :string
  end
end
