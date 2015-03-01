ActiveAdmin.register Invest do
  permit_params :user_id, :fund_id, :initial_amount, :amount, :date, :payback, :close_day, :created_at, :updated_at
end