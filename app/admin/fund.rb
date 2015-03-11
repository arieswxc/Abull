ActiveAdmin.register Fund do
  permit_params :name, :user_id, :amount, :collection_deadline, :earning, :expected_earning_rate, :earning_rate, :state, :private_check, :minimum, :invest_starting_date, :invest_ending_date, :description, :risk_method, :initial_amount, :created_at, :updated_at
    
  index do
    selectable_column
    column "标名*", :name
    column "募集数额*", :amount
    column "最小值*", :minimum
    column "明(暗)标*", :private_check
    column "投资方向", :description
    column "风控措施", :risk_method
    column "募集截止时间*", :collection_deadline
    column "操盘开始时间*", :invest_starting_date
    column "操盘结束时间*", :invest_ending_date
    column "状态", :state
    column "确认" do |fund|
      link_to t('confirm'), confirm_fund_admin_fund_path(fund), :method => :put, :class => 'button'
    end
    column "拒绝" do |fund|
      if fund.state == 'pending'
        link_to t('deny'), deny_fund_admin_fund_path(fund), :method => :put, :class => 'button'
      end
    end
    actions defaults: false do |fund|
      item "Preview", admin_fund_path(fund), class: "member_link"
      item "Edit", edit_admin_fund_path(fund), class: "member_link"
    end
  end

  # page of show
  show do |fund|
    attributes_table  do 
      row('标名')           { |f| f.name }
      row('募集资金')       { |f| f.amount }
      row('募集截止时间')   { |f| f.collection_deadline }
      row('最小值')        { |f| f.minimum }
      row('明(暗)标')      { |f| f.private_check }
      row('操盘开始时间')   { |f| f.invest_starting_date }
      row('操盘结束时间')   { |f| f.invest_ending_date }      
      row('投资方向')      { |f| f.description}
      row('风控措施')      { |f| f.risk_method }
      row('状态')          { |f| f.state }      
    end

    panel t('操盘手个人信息') do 
      attributes_table_for fund.user do
        row('电子邮件')  { |u| u.email }
        row('昵称')     { |u| u.nick_name }
        row('真实姓名')  { |u| u.real_name }
        row('手机')     { |u| u.cell }
        row('身份证号')  { |u| u.id_card_number }
        row :abstract
        row('用户等级')  { |u| u.level }
        row :current_sign_in_at
        row :sign_in_count
        row('用户创建日期') { |u| u.created_at }
      end
    end

  end
 
  # page of new and edit
  form do |f|
      f.inputs t('Edit') do
        # f.input :name
        # f.input :amount
        # f.input :collection_deadline
        # f.input :minimum
        # f.input :invest_starting_date
        # f.input :invest_ending_date
        # f.input :state, as: :select, collection: ["还未审核", "待审核", "已审核", "审核失败"], :label => "状态"
        f.input :state, as: :select, collection: ["pending", "applied", "gathering", "reached", "opened", "running", "finished", "closed"]
        # f.input :reject_reason, :label => "退回说明"
      end
      f.actions
  end

  member_action :confirm_fund, :method => :put do 
    fund = Fund.find(params[:id])
    if fund.state == 'pending'
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
    else fund.state == 'finished'
      fund.close
    end      
    redirect_to admin_funds_path
  end

  member_action :deny_fund, :method => :put do
    fund = Fund.find(params[:id])
    fund.deny
    redirect_to admin_funds_path
  end

end