ActiveAdmin.register Leverage do
  permit_params :user_id, :date, :amount, :description, :duration, :state, :created_at, :updated_at, :interest_id

  index do
    selectable_column
    id_column
    column :user_id
    column :date
    column :amount
    column :duration
    column :state
    column :interest_id
    column :description
    actions
  end

  filter :email
  filter :role
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show do |leverage|
    attributes_table do 
      row :user_id
      row :date
      row :amount
      row :duration
      row :state
      row('同意')  do 
          link_to t('Agree'), agree_leverage_admin_leverage_path(leverage), :method => :put, :class => 'button' 
      end
      row('拒绝')  do 
          link_to t('Deny'), deny_leverage_admin_leverage_path(leverage), :method => :put, :class => 'button' 
      end
      row :interest_id
      row :description
      row :updated_at
      row :created_at
    end
  end

  member_action :agree_leverage, :method => :put do
    leverage = Leverage.find(params[:id])
    if leverage.state == 'applied' 
      leverage.confirm
    elsif leverage.state == 'confirmed'
      leverage.close
    end
    redirect_to admin_leverage_path(leverage)
  end

  member_action :deny_leverage, :method => :put do
    leverage = Leverage.find(params[:id])
    if leverage.state = 'applied'
      leverage.deny 
    end
    redirect_to admin_leverage_path(leverage)
  end

  
end