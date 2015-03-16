class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user, index: true
      t.decimal :balance, precision: 12, scale: 2, default: 0

      t.timestamps null: false
    end
    add_foreign_key :accounts, :users
  end
end
