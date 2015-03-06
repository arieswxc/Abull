class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.string :photo
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :photos, :users
  end
end
