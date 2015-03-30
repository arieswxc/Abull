class CreateFundAccounts < ActiveRecord::Migration
  def change
    create_table :fund_accounts do |t|
      t.references :fund, index: true
      t.decimal :balance, precision: 12, scale: 2, default: 0

      t.timestamps null: false
    end
    add_foreign_key :fund_accounts, :funds
  end
end
