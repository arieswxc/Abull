ActiveAdmin.register Fund do
  permit_params :name, :user_id, :amount, :collection_deadline, :earning, :expected_earning_rate, :earning_rate, :state, :private_check, :minimum, :invest_starting_date, :invest_ending_date, :description, 
    	:frontend_risk_method, 
  		:backend_risk_method, :initial_amount, :created_at, :updated_at
    
  index do
    selectable_column
    column :name
    column :amount
    column :minimum
    column :private_check
    column :description
    column :frontend_risk_method
    column :backend_risk_method
    column :collection_deadline
    column :invest_starting_date
    column :invest_ending_date
    column :state
    actions defaults: false do |fund|
      item "Preview", admin_fund_path(fund), class: "member_link"
      item "Edit", edit_admin_fund_path(fund), class: "member_link"
    end
  end

  # page of show
  show do |fund|
    attributes_table  do 
      row :name
      row :amount
      row :collection_deadline
      row :minimum
      row :private_check
      row :invest_starting_date
      row :invest_ending_date
      row :description
      row :frontend_risk_method
      row :backend_risk_method
      row :state
    end

    panel t('操盘手个人信息') do 
      attributes_table_for fund.user do
        row :email
        row :nick_name
        row :real_name
        row :cell
        row :id_card_number
        row :abstract
        row :level
        row :current_sign_in_at
        row :sign_in_count
        row :created_at
      end
    end
  end

  #侧边窗口
  sidebar "状态变更", only: :show do
    attributes_table_for fund do
      row('确认')  do 
        link_to t('confirm'), confirm_fund_admin_fund_path(fund), :method => :put, :class => 'button'
      end
      row('拒绝')  do
        if fund.state == 'applied'
          link_to t('deny'), deny_fund_admin_fund_path(fund), :method => :put, :class => 'button'
        end
      end
    end
  end
 
  # page of new and edit
  form do |f|
      f.inputs do
        f.input :name
        f.input :amount
        f.input :collection_deadline, as: :datepicker
        f.input :minimum
        f.input :invest_starting_date, as: :datepicker
        f.input :invest_ending_date, as: :datepicker
        f.input :state, as: :select, collection: ["pending", "applied", "gathering", "reached", "opened", "running", "finished", "closed", "denied"]
        f.input :user_id, as: :select, collection: User.order(:email).map{|u| [u.email, u.id]}
      end
      f.actions
  end

  member_action :confirm_fund, :method => :put do 
    fund = Fund.find(params[:id])
    if fund.state == 'pending'
      fund.apply
    elsif fund.state == 'denied'
      fund.apply
    elsif fund.state == 'applied'
      fund.approve
    elsif fund.state == 'gathering'
      fund.reach
    elsif fund.state == 'reached'
      fund.open_homs
    elsif fund.state == 'opened'
      fund.run 
    elsif fund.state == 'running'
      fund.finish
    elsif fund.state == 'finished'
      fund.close
    elsif fund.state == 'closed'
      fund.reset
    end      
    redirect_to admin_fund_path(fund)
  end

  member_action :deny_fund, :method => :put do
    fund = Fund.find(params[:id])
    fund.deny
    redirect_to admin_fund_path(fund)
  end

end