class AddBackendRiskMethodToFund < ActiveRecord::Migration
  def change
    add_column :funds, :back_end_risk_method, :text
  end
end
