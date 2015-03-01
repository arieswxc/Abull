ActiveAdmin.register Fund do
  permit_params :name, :user_id, :amount, :collection_deadline, :earning, :expected_earning_rate, :earning_rate, :state, :private_check, :minimum, :invest_starting_date, :invest_ending_date, :description, :risk_method, :initial_amount, :created_at, :updated_at
end