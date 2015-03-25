class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verify_file, :string
    add_column :users, :line_csv, :string
    remove_column :funds, :verify_file
    remove_column :funds, :line_csv
  end
end
