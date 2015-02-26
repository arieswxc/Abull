ActiveAdmin.register Invest do
  permit_params :user_id, :fund_id, :number, :date, :created_at, :updated_at
end