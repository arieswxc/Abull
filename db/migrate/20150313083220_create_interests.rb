class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.integer :leverage_time, null: false
      t.decimal :amount, precision: 12, scale: 2, default: 0, null: false
      t.integer :duration, null: false
      t.decimal :interest_rate, precision: 12, scale: 2, null: false
      t.decimal :managerment_fee, precision: 12, scale: 2

      t.timestamps null: false
    end
  end
end
