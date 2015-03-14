class AddInterestIdToLeverage < ActiveRecord::Migration
  def change
    add_reference :leverages, :interest, index: true
    add_foreign_key :leverages, :interests
  end
end
