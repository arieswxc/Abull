ActiveAdmin.register Interest do
  permit_params :leverage_time, :amount, :duration, :interest_rate, :managerment_fee
end