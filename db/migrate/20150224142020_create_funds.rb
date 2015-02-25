class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.string :name
      t.references :user, index: true
      t.decimal :amount, precision: 12, scale: 2
      t.datetime :colleciton_deadline
      t.decimal :earning, precision: 12, scale: 2, default: 0
      t.decimal :earning_rate, precision: 6, scale: 4
      t.string :state
      t.boolean :private_check, default: true
      t.decimal :minimum, precision: 12, scale: 2
      t.datetime :invest_starting_date
      t.datetime :invest_ending_date

      t.timestamps null: false
    end
    add_foreign_key :funds, :users
  end
end
