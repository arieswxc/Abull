class ChangeColumnNameOfLeverages < ActiveRecord::Migration
  def change
    change_table :leverages do |t|
      t.rename :number, :amount
    end
  end
end
