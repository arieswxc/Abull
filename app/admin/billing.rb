ActiveAdmin.register Billing do
  permit_params :account_id, :amount, :billing_type, :billable_type, :billable_id
end