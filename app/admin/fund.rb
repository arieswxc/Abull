ActiveAdmin.register Fund do
  permit_params :name, :user_id, :amount, :ending_days, :earning, :expected_earning_rate, :earning_rate, :state, :private_check, :minimum, :invest_starting_date, :invest_ending_date, :description, 
    	:frontend_risk_method, :duration, :mandate, :management_fee,
  		:backend_risk_method, :initial_amount, :created_at, :updated_at, :raised_amount, :genre, :private_code,fund_verify_photos_attributes: [:title, :photo],
      line_csv_attributes: [:title, :file]
  index do
    selectable_column
    column :id
    column :name
    column :amount
    column :minimum
    column :private_check
    # column :description
    column :ending_days
    column :invest_starting_date
    column :invest_ending_date
    column :state do |fund|
      t(fund.state)
    end
    column :management_fee
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
      row :description do
        sanitize(fund.description.truncate(30)) if fund.description
      end
      row :line_csv
      row :frontend_risk_method do
        sanitize(fund.frontend_risk_method.truncate(30)) if fund.frontend_risk_method
      end
      row :backend_risk_method do
        sanitize(fund.backend_risk_method.truncate(30)) if fund.backend_risk_method
      end
      row :management_fee
    end
  
    panel t('证明文件照片') do
      table_for fund.fund_verify_photos do |f| 
        column "标题", :title
        column "照片" do |f|
          image_tag f.photo, width:400, height:400
        end
      end
    end

    panel t('Homs') do 
      attributes_table_for fund.homs_account do
        row :title do
          link_to fund.homs_account.title, admin_homs_account_path(fund.homs_account)
        end
        row :password
        row :amount
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
          link_to i.user.username, admin_user_path(i.user_id)
        end
        column "投标数额", :amount
      end
    end
  end

  # 侧边窗口
  sidebar "控制栏", only: :show do
    panel t("发标状态操控") do
      attributes_table_for fund do
        row :state do |fund|
          t(fund.state)
        end
        row('状态提升')  do 
          link_to t('Confirm'), confirm_fund_admin_fund_path(fund), :method => :put, :class => 'button'
        end
        row('拒绝发标申请')  do 
          if fund.state == 'applied'
            link_to t('Reject'), deny_fund_admin_fund_path(fund), :method => :get, :class => 'button'
          end
        end          
        row('填写拒绝原因')  do
          if fund.state == 'denied'
            form_for "Reason", url: input_reason_admin_fund_path(fund), method: :post do |f|
              f.text_area :reason
              f.submit
            end        
          end
        end
      end
    end
    panel t("发标通知") do  
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
    panel t("清盘") do  
      attributes_table_for fund do 
        row('清盘')  do 
          link_to t('confirm'), liquidate_admin_fund_path(fund), :method => :get, :class => 'button'
        end
      end
    end
  end

  # page of new and edit
  form do |f|
      f.inputs do
        f.input :name
        f.input :amount
        f.input :ending_days
        f.input :earning
        f.input :earning_rate
        f.input :private_check
        f.input :private_code
        f.input :description, as: :wysihtml5 
        f.input :frontend_risk_method, as: :wysihtml5
        f.input :backend_risk_method, as: :wysihtml5
        f.input :initial_amount
        f.input :mandate, as: :select, collection: [ 'true', 'false' ]
        f.input :minimum
        f.input :invest_starting_date, as: :datepicker
        f.input :duration
        f.input :genre
        f.input :expected_earning_rate
        f.input :state, as: :select, collection: ["pending", "applied", "gathering", "reached", "opened", "running", "finished", "closed", "denied"]
        f.input :user_id
        f.input :management_fee
        f.inputs "上传证明文件" do
          f.has_many :fund_verify_photos do |t|
            t.input :title
            t.input :photo
          end
        end
      end
        f.inputs "上传csv文件", for: [:line_csv, f.object.line_csv] do |file|
          file.input :title
          file.input :file
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
      billing_out = fund.user.account.billings.build(
        amount:       -fund.amount, 
        billing_type: "From Fund Account",
        billable:     fund.fund_account)
      billing_in = fund.user.account.billings.build(
        amount:       fund.amount, 
        billing_type: "To homs_account",
        billable:     fund.homs_account)
      fund_account          = fund.fund_account
      homs_account          = fund.homs_account
      fund_account.balance  -= fund.amount
      homs_account.amount   += fund.amount
      ActiveRecord::Base.transaction do
        billing_in.save
        billing_out.save
        fund_account.save
        homs_account.save
        fund.open_homs
      end
    elsif fund.state == 'opened'
      if fund.homs_account.title == 'undefined'
      else
        fund.run
      end 
    elsif fund.state == 'running'
      fund.finish
    elsif fund.state == 'finished'
      fund.close
    elsif fund.state == 'closed'
      fund.reset
    end      
    redirect_to admin_fund_path(fund)
  end

  member_action :deny_fund, :method => :get do
    fund = Fund.find(params[:id])
    fund.deny if fund.state == 'applied'
    redirect_to admin_fund_path(fund)
  end

  member_action :input_reason, :method => :post do
    fund = Fund.find(params[:id])
    ActiveAdmin::Comment.create("resource" => fund, "body"=>"#{params[:Reason][:reason]}", "namespace": "admin")
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

  member_action :liquidate, :method => :get do
    fund = Fund.find(params[:id])
    homs_account = fund.homs_account

    profit            = homs_account.amount - fund.amount
    management_profit = (profit > 0) ? profit * (fund.management_fee.to_f / 100) : 0 
    shared_profit     = profit - management_profit
    rate              = (shared_profit / fund.amount) + 1

    if profit > 0
      funder_account = fund.user.account
      fund_billing_out = Billing.new(
        account_id:     funder_account.id,
        amount:         -management_profit,
        billing_type:   "清盘返现",
        billable:       fund)
      fund_billing_in = Billing.new(
        account_id:     funder_account.id,
        amount:         management_profit,
        billing_type:   "清盘提款",
        billable:       fund)
      homs_account.amount     += fund_billing_out.amount
      funder_account.balance  += fund_billing_in.amount
      ActiveRecord::Base.transaction do
        fund_billing_in.save
        fund_billing_in.confirm
        fund_billing_out.save
        fund_billing_out.confirm
        homs_account.save
        funder_account.save
      end
    end

    fund.invests.each do |invest|
      account = invest.user.account
      billing_in = Billing.new(
        account_id:   account.id,
        amount:       (invest.amount * rate),
        billing_type: "清盘返现",
        billable:     invest)
      billing_out = Billing.new(
        account_id:   fund.user.account.id,
        amount:       -(invest.amount * rate),
        billing_type: "清盘提款",
        billable:      fund)
      account.balance       += billing_in.amount
      homs_account.amount  += billing_out.amount
      ActiveRecord::Base.transaction do
        account.save
        homs_account.save
        billing_in.save
        billing_in.confirm
        billing_out.save
        billing_out.confirm
      end
    end

    if homs_account.amount == 0
      fund.close
    end
    redirect_to admin_fund_path(fund)
  end
end