class DelDatefromLeverages < ActiveRecord::Migration
  def change
    remove_column :leverages, :begining_date
    remove_column :leverages, :ending_date
  end
end
