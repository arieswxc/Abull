class AddMoreFiledToUsers < ActiveRecord::Migration
  def change
    add_column :users, :id_card_number, :string
    add_column :users, :abstract, :text
    add_column :users, :level, :string
  end
end
