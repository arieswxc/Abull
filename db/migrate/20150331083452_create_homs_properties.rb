class CreateHomsProperties < ActiveRecord::Migration
  def change
    create_table :homs_properties do |t|
      t.date :date
      t.decimal :amount, precision: 12, scale: 2, default: 0
      t.references :homs_account, index: true

      t.timestamps null: false
    end
    add_foreign_key :homs_properties, :homs_accounts
  end
end
