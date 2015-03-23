ActiveAdmin.register Account do
  permit_params :balance, :user_id

  index do
    selectable_column
    id_column
    column :user_id
    column :balance
    column :created_at
    column :updated_at
    actions
  end

  filter :user_id
  filter :balance

  show do |account|
    attributes_table  do 
      row :user_id
      row :balance
      row :created_at
      row :updated_at
      row('通知:支付宝转账确认')  do 
          link_to t('confirm'), confirm_zhifubao_admin_account_path(account), :method => :get, :class => 'button'
      end
      row('通知:线下充值确认')  do 
          link_to t('confirm'), confirm_charge_admin_account_path(account), :method => :get, :class => 'button'
      end
      row('通知:客户申请提现确认')  do 
          link_to t('confirm'), confirm_withdraw_admin_account_path(account), :method => :get, :class => 'button'
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

  member_action :confirm_charge, :method => :get do
    user = resource.user
    UserMailer.welcome_email(user).deliver_now
    redirect_to admin_account_path(resource)
  end

  member_action :confirm_zhifubao, :method => :get do
    user = resource.user
    UserMailer.welcome_email(user).deliver_now
    redirect_to admin_account_path(resource)
  end

  member_action :confirm_withdraw, :method => :get do
    user = resource.user
    UserMailer.welcome_email(user).deliver_now
    redirect_to admin_account_path(resource)
  end


end