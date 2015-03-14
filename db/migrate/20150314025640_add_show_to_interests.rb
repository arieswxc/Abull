class AddShowToInterests < ActiveRecord::Migration
  def change
    add_column :interests, :show, :string, default: "false"
  end
end
