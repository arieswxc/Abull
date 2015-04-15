ActiveAdmin.register FundAccount do
  menu priority: 12
  permit_params :balance, :fund_id
end