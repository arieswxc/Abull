class CreateCsvFiles < ActiveRecord::Migration
  def change
    create_table :csv_files do |t|
      t.string :file
      t.string :title
      t.timestamps null: false
    end
  end
end
