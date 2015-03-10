ActiveAdmin.register Fund do
  # scope_to do
  #   Fund.where(state: "还未审核") if current_user.type  == "?"
  #   Fund.where(state: "待审核")   if current_user.type  == "?"
  #   Fund.all                     if current_user.type  == "?"
  # end

  permit_params :name, :user_id, :amount, :collection_deadline, :earning, :expected_earning_rate, :earning_rate, :state, :private_check, :minimum, :invest_starting_date, :invest_ending_date, :description, :risk_method, :initial_amount, :created_at, :updated_at
  # permit_params :state
    
  index do
    selectable_column
    column "标名*", :name
    column "募集数额*", :amount
    column "最小值*", :minimum
    column "明(暗)标*", :private_check
    column "投资方向", :description
    column "风控措施", :risk_method
    column "状态", :state
    column "募集截止时间*", :collection_deadline
    column "操盘开始时间*", :invest_starting_date
    column "操盘结束时间*", :invest_ending_date
    actions defaults: false do |fund|
      item "Preview", admin_fund_path(fund), class: "member_link"
      item "Edit", edit_admin_fund_path(fund), class: "member_link"
    end
  end

  #   actions
  # end

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

end