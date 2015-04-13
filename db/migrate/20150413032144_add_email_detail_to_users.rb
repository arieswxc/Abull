class AddEmailDetailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active_email, :string
    add_column :users, :email_code, :string
  end
end
