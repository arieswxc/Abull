class AddEndingDaysToFunds < ActiveRecord::Migration
  def change
    remove_column :funds, :collection_deadline
    add_column :funds, :ending_days, :integer
  end
end
