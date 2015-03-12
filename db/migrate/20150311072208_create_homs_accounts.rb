class CreateHomsAccounts < ActiveRecord::Migration
  def change
    create_table :homs_accounts do |t|
      t.string :title
      t.string :password

      t.timestamps null: false
    end
  end
end
