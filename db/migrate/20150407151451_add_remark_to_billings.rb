class AddRemarkToBillings < ActiveRecord::Migration
  def change
    add_column :billings, :remark, :string
  end
end
