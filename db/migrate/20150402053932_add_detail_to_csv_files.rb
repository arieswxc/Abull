class AddDetailToCsvFiles < ActiveRecord::Migration
  def change
    add_column :csv_files, :data_file_id, :string
    add_column :csv_files, :data_file_type, :string
    remove_column :funds, :line_csv
    remove_column :users, :line_csv
  end
end
