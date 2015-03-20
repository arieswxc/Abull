class AddCellToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :cell, :string
  end
end
