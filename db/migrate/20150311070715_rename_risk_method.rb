class RenameRiskMethod < ActiveRecord::Migration
  def change
  	rename_column :funds, :risk_method, :frontend_risk_method
  end
end
