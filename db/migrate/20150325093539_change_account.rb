class ChangeAccount < ActiveRecord::Migration
  def change
    rename_column :accounts, :freeze, :frost
  end
end
