class AddDetailToLeverages < ActiveRecord::Migration
  def change
    add_column :leverages, :loss_warning_line, :integer
    add_column :leverages, :loss_making_line, :integer
    add_column :leverages, :rate, :integer
    add_column :leverages, :total_interests, :integer
    add_column :leverages, :deposit, :integer
    add_column :leverages, :begining_date, :date 
    add_column :leverages, :ending_date, :date
    add_column :leverages, :leverage_amount, :integer
    remove_column :funds, :freezed_amount
  end
end
