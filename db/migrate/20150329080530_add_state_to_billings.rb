class AddStateToBillings < ActiveRecord::Migration
  def change
    add_column :billings, :state, :string
  end
end
