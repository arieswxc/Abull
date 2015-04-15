ActiveAdmin.register Account do
  menu priority: 2
  permit_params :balance, :user_id, :frost

  index do
    selectable_column
    id_column
    column :user do |account|
      account.user.username
    end
    column :balance
    column :frost
    column :created_at
    column :updated_at
    actions
  end

  filter :user_id
  filter :balance


  show do |account|
    attributes_table  do 
      row('用户id') do 
        link_to account.user.username, admin_user_path(account.user_id)
      end
      row :balance
      row :created_at
      row :updated_at
    end
    panel t('用户通知') do 
      attributes_table_for account do
        row('支付宝转账确认')  do 
          form_for "input", url: confirm_zhifubao_admin_account_path(account), method: :post do |f|
            f.text_field :amount
            f.submit
          end
        end 
        row('线下充值确认')  do 
          form_for "input", url: confirm_charge_admin_account_path(account), method: :post do |f|
            f.text_field :amount
            f.submit
          end
        end
        row('客户申请提现确认')  do 
          form_for "input", url: confirm_withdraw_admin_account_path(account), method: :post do |f|
            f.text_field :amount
            f.submit
          end
        end
      end
    end
  end

  form do |f|
    f.inputs "Account Details" do
      f.input :user_id
      f.input :balance
    end
    f.actions
  end

  member_action :confirm_charge, :method => :post do
    flash[:notice] = "发送成功"
    inform(resource, 'offline', params[:input][:amount])
  end

  member_action :confirm_zhifubao, :method => :post do
    flash[:notice] = "发送成功"
    inform(resource, 'zhifubao', params[:input][:amount])
  end

  member_action :confirm_withdraw, :method => :post do
    flash[:notice] = "发送成功"
    inform(resource, 'withdraw', params[:input][:amount])
  end


end