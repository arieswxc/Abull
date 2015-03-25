ActiveAdmin.register BankCard do
  permit_params :user_id, :number, :bank_name, :bank_branch, :state
end