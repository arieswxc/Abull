class AddMandateToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :mandate, :boolean
  end
end
