ActiveAdmin.register Fund do
  permit_params :name, :user_id, :amount, :collection_deadline, :earning, :earning_rate, :state, :private_check, :minimum, :invest_starting_date, :invest_ending_date, :created_at, :updated_at
end