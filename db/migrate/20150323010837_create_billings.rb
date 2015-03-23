class CreateBillings < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.references :account, index: true
      t.decimal :amount, precision: 12, scale: 2, default: 0
      t.string :billing_type
      t.references :billable, polymorphic: true, index: true

      t.timestamps null: false
    end
    add_foreign_key :billings, :accounts
  end
end
