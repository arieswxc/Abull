class AddAttributesTofund < ActiveRecord::Migration
  def change
    add_column :funds, :private_code, :integer
    add_column :funds, :freezed_amount, :integer
  end
end
