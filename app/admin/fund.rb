ActiveAdmin.register Fund do
  permit_params :name, :user_id, :amount, :ending_days, :earning, :expected_earning_rate, :earning_rate, :state, :private_check, :minimum, :invest_starting_date, :invest_ending_date, :description, 
    	:frontend_risk_method, :duration, :mandate,
  		:backend_risk_method, :initial_amount, :created_at, :updated_at, :raised_amount, :genre, :private_code
    
  index do
    selectable_column
    column :name
    column :amount
    column :minimum
    column :private_check
    column :description
    column :frontend_risk_method
    column :backend_risk_method
    column :ending_days
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
      row :id
      row :name
      row :amount
      row :raised_amount
      row :ending_days
      row :minimum
      row :private_check
      row :private_code
      row :expected_earning_rate
      row :genre
      row :invest_starting_date
      row :invest_ending_date
      row :description
      row :frontend_risk_method
      row :backend_risk_method
      row :state
      row('升级')  do 
          link_to t('confirm'), confirm_fund_admin_fund_path(fund), :method => :put, :class => 'button'
      end    
      row('拒绝')  do
        if fund.state == 'applied'
          form_for "reject_reason", url: deny_fund_admin_fund_path(fund), method: :post do |f|
            f.text_area :reason
            f.submit
          end        
        end
      end
    end

    panel t('操盘手个人信息') do 
      attributes_table_for fund.user do
        row :email
        row :username
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

    panel t('该标的投标信息') do
      table_for fund.invests do
        column "用户" do |i|
          link_to User.find(i.user_id).email, admin_user_path(i.user_id)
        end
        column :amount
      end
    end
  end

  # 侧边窗口
  sidebar "Fund 通知", only: :show do
    attributes_table_for fund do 
      row('发标审核通过')  do 
        link_to t('confirm'), fund_confirm_inform_admin_fund_path(fund), :method => :get, :class => 'button'
      end
      row('发标审核未通过')  do 
        link_to t('confirm'), fund_deny_inform_admin_fund_path(fund), :method => :get, :class => 'button'
      end
      row('发标提前清盘')  do 
        link_to t('confirm'), fund_liquidation_inform_admin_fund_path(fund), :method => :get, :class => 'button'
      end   
    end
  end

  # page of new and edit
  form do |f|
      f.inputs do
        f.input :name
        f.input :amount
        f.input :ending_days
        f.input :mandate, as: :select, collection: [ 'true', 'false' ]
        f.input :minimum
        f.input :invest_starting_date, as: :datepicker
        f.input :duration
        f.input :genre
        f.input :expected_earning_rate
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

  member_action :deny_fund, :method => :post do
    fund = Fund.find(params[:id])
    ActiveAdmin::Comment.create("resource" => fund, "body"=>"#{params[:reject_reason][:reason]}", "namespace": "admin")
    fund.deny
    redirect_to admin_fund_path(fund)
  end

  member_action :fund_confirm_inform, :method => :get do
    fund_inform(resource, 'fund_confirm_inform')
  end

  member_action :fund_deny_inform, :method => :get do
    fund_inform(resource, 'fund_deny_inform')
  end

  member_action :fund_liquidation_inform, :method => :get do
    fund_inform(resource, 'fund_liquidation_inform')
  end

end