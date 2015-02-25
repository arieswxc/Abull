class CreateInvests < ActiveRecord::Migration
  def change
    create_table :invests do |t|
      t.references :user, index: true
      t.references :fund, index: true
      t.decimal :number, precision: 12, scale: 2, default: 0
      t.datetime :date

      t.timestamps null: false
    end
    add_foreign_key :invests, :users
    add_foreign_key :invests, :funds
  end
end
