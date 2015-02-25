class ChangColumnNameOfFund < ActiveRecord::Migration
  def change
    change_table :funds do |t|
      t.rename :colleciton_deadline, :collection_deadline
    end
  end
end
