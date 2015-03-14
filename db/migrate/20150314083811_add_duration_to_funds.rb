class AddDurationToFunds < ActiveRecord::Migration
  def change
    change_table :funds do |t|
      t.remove :invest_ending_date
      t.integer :duration
    end
  end
end
