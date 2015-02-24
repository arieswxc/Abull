class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nick_name, :string
    add_column :users, :real_name, :string
  end
end
