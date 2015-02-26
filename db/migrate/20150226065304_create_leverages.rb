class CreateLeverages < ActiveRecord::Migration
  def change
    create_table :leverages do |t|
      t.references :user, index: true
      t.datetime :date
      t.decimal :number, precision: 12, scale: 2
      t.text :description
      t.datetime :deadline
      t.string :state

      t.timestamps null: false
    end
    add_foreign_key :leverages, :users
  end
end
