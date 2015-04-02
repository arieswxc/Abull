class AddTypeToCsv < ActiveRecord::Migration
  def change
    add_column :csv_files, :csv_file_type, :string
  end
end
