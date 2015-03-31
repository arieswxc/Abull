class AddBillingNumberToBillings < ActiveRecord::Migration
  def change
    add_column :billings, :billing_number, :string
  end
end
