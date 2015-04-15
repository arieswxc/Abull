ActiveAdmin.register HomsProperty do
  menu priority: 13
  permit_params :date, :amount, :homs_account_id
end