ActiveAdmin.register Account do
  permit_params :balance, :user_id
end