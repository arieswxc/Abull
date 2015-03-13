class AddFundIdToHomsAccounts < ActiveRecord::Migration
  def change
    add_reference :homs_accounts, :fund, index: true
    add_foreign_key :homs_accounts, :funds
  end
end
