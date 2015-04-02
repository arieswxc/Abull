ActiveAdmin.register HomsAccount do
  permit_params :title, :password, :fund_id, :amount

  index do
    selectable_column
    id_column
    column :fund_id do |homs_account|
      homs_account.fund.name
    end
    column :title
    column :amount
    column :password
    actions
  end
end
