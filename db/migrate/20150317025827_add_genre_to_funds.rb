class AddGenreToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :genre, :string
  end
end
