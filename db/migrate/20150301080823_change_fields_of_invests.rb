class ChangeFieldsOfInvests < ActiveRecord::Migration
  def change
    rename_column :invests, :number, :amount
    add_column :invests, :payback, :decimal, precision: 12, scale: 2
    add_column :invests, :close_day, :datetime
  end
end
