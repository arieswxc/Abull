class RenameUsernameOfUsers < ActiveRecord::Migration
  def change
    rename_column :users, :nick_name, :username
  end
end
