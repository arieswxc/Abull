ActiveAdmin.register Leverage do
  permit_params :user_id, :date, :number, :description, :deadline, :state, :created_at, :updated_at
end