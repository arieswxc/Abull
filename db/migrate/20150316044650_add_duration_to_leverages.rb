class AddDurationToLeverages < ActiveRecord::Migration
  def change
    change_table :leverages do |t|
      t.remove  :deadline
      t.integer :duration
    end
  end
end
