ActiveAdmin.register BankCard do
  menu priority: 3
  permit_params :user_id, :number, :bank_name, :bank_branch, :state

  index do
    selectable_column
    column :id
    column :number
    column :bank_name
    column :bank_branch
    column :state do |bank_card|
      t(bank_card.state)
    end
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :number
      f.input :bank_name
      f.input :bank_branch
      f.input :state, as: :select, collection: [["待定", "pending"], ["确认", "approved"]]
    end
    f.actions
  end

  show do |bank_card|
    attributes_table do
      row :id
      row :number
      row :bank_name
      row :bank_branch
      row :state do
        t(bank_card.state)
      end
      row :created_at
      row :updated_at
    end
  end

  sidebar "控制栏", only: :show do
    panel "状态操控" do
      attributes_table_for bank_card do
        row :state do
          t(bank_card.state)
        end
        row :state do
          link_to t('confirm'), confirm_bank_card_admin_bank_card_path(bank_card), method: :get, class: 'button'
        end
      end
    end
  end

  member_action :confirm_bank_card, method: :get do
    bank_card = BankCard.find(params[:id])
    if bank_card.state == "pending"
      bank_card.approve
    end
    redirect_to admin_bank_card_path(bank_card)
  end
end