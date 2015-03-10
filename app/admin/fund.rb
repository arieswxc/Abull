ActiveAdmin.register Fund do
  scope_to do
    Fund.where(state: "还未审核") if current_user.type  == "?"
    Fund.where(state: "待审核")   if current_user.type  == "?"
    Fund.all                     if current_user.type  == "?"
  end

  # permit_params :name, :user_id, :amount, :collection_deadline, :earning, :expected_earning_rate, :earning_rate, :state, :private_check, :minimum, :invest_starting_date, :invest_ending_date, :description, :risk_method, :initial_amount, :created_at, :updated_at
  permit_params :state
  
  filter :state, as: :select, :collection => ["还未审核", "待审核", "已审核", "审核失败"]
  
  index do
    selectable_column
    column "标名*", :name
    column "募集数额*", :amount
    column "募集截止时间*", :collection_deadline
    column "最小值*", :minimum
    column "明(暗)标*", :private_check
    column "操盘开始时间*", :invest_starting_date
    column "操盘结束时间*", :invest_ending_date
    column "投资方向", :description
    column "风控措施", :risk_method
    column "状态", :state
    actions
  end

  # page of new and edit
  form do |f|
      f.inputs t('Edit') do
        f.input :state, as: :select, collection: ["还未审核", "待审核", "已审核", "审核失败"], :label => "状态"
        # f.input :reject_reason, :label => "退回说明"
      end
      f.actions
  end

end