class AddDetailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :date
    add_column :users, :gender, :string
    add_column :users, :education, :string
    add_column :users, :address, :string
    add_column :users, :job, :string
  end
end
