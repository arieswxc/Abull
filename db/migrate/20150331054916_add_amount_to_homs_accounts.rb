class AddAmountToHomsAccounts < ActiveRecord::Migration
  def change
    add_column :homs_accounts, :amount, :decimal, precision: 12, scale: 2, default: 0
  end
end
