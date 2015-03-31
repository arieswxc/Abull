class AddFrostToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :frost, :decimal, precision: 12, scale: 2, default: 0
  end
end
