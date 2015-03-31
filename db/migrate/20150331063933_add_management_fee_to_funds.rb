class AddManagementFeeToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :management_fee, :decimal, default: 0
  end
end
