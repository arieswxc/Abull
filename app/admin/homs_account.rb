ActiveAdmin.register HomsAccount do
  menu priority: 9
  permit_params :title, :password, :fund_id, :amount

  index do
    selectable_column
    id_column
    column :fund_id do |homs_account|
      link_to homs_account.fund.name, admin_fund_path(homs_account.fund)
    end
    column :title
    column :amount
    column :password do |homs_account|
      homs_account.password.to_s
    end
    actions
  end

    form do |f|
      f.inputs do
        f.input :fund
        f.input :title
        f.input :password, as: :string
        f.input :amount
      f.actions
    end
  end
end
