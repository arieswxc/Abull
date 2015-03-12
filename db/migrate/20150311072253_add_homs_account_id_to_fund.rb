class AddHomsAccountIdToFund < ActiveRecord::Migration
  def change
    add_column :funds, :homs_account, :integer
  end
end
