ActiveAdmin.register Invest do
  menu priority: 10
  permit_params :user_id, :fund_id, :initial_amount, :amount, :date, :payback, :close_day, :created_at, :updated_at

  index do
    selectable_column
    id_column
    column :user_id do |invest|
      invest.user.username
    end
    column :fund_id
    column :initial_amount
    column :amount
    column :date
    column :payback
    column :close_day
    column :created_at
    column :updated_at
    actions
  end

  filter :user_id
  filter :balance


  show do |invest|
    attributes_table  do 
      row :id
      row('用户id') do 
        link_to invest.user_id, admin_user_path(invest.user_id)
      end
      row :fund_id
      row :initial_amount
      row :amount
      row :date
      row :payback
      row :close_day
      row :created_at
      row :updated_at
    end
  end

  sidebar "用户通知", only: :show do
    attributes_table_for invest do
      row('投标提前清盘')  do 
        link_to t('confirm'), advanced_liquidation_admin_invest_path(invest), :method => :get, :class => 'button'
      end 
      row('投标到期清盘')  do
        link_to t('confirm'), due_liquidation_admin_invest_path(invest), :method => :get, :class => 'button'
      end
    end
  end

  member_action :advanced_liquidation, :method => :get do
    flash[:notice] = "发送成功"
    invest_inform(resource, 'advanced_liquidation')
  end

  member_action :due_liquidation, :method => :get do
    flash[:notice] = "发送成功"
    invest_inform(resource, 'due_liquidation')
  end

end