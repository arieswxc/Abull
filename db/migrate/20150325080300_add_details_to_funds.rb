class AddDetailsToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :verify_file, :string
    add_column :funds, :line_csv, :string
  end
end
