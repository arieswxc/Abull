class CreateBankCards < ActiveRecord::Migration
  def change
    create_table :bank_cards do |t|
      t.string :number
      t.string :bank_name
      t.string :bank_branch
      t.references :user, index: true
      t.string :state

      t.timestamps null: false
    end
    add_foreign_key :bank_cards, :users
  end
end
