class RenameColumnOfFund < ActiveRecord::Migration
  def change
    rename_column :funds, :back_end_risk_method, :backend_risk_method
  end
end
