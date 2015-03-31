class AddCsvToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :line_csv, :string
  end
end
