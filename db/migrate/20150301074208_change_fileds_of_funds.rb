class ChangeFiledsOfFunds < ActiveRecord::Migration
  def up
    add_column :funds, :expected_earning_rate, :decimal, precision: 12, scale: 4
    change_column :funds, :earning_rate, :decimal, precision: 12, scale: 4 
    change_column :funds, :private_check, :string, default: "private"
    add_column :funds, :description, :text
    add_column :funds, :risk_method, :text
    add_column :funds, :initial_amount, :decimal, precision: 12, scale: 2
  end

  def down
    remove_column :funds, :expected_earning_rate, :decimal, precision: 12, scale: 4
    change_column :funds, :earning_rate, :decimal, precision: 6, scale: 4 
    change_column :funds, :private_check, :boolean, default: true
    remove_column :funds, :description, :text
    remove_column :funds, :risk_method, :text
    remove_column :funds, :initial_amount, :decimal, precision: 12, scale: 2
  end
end
