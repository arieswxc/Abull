ActiveAdmin.register Leverage do
  menu priority: 14
  permit_params :user_id, :date, :amount, :description, :duration, :state, :created_at, :updated_at, :interest_id,
                :rate, :total_interests, :leverage_amount

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
      row :id
      row :user_id
      row :date
      row :amount
      row :duration
      row :rate
      row :total_interests
      row :leverage_amount
      row :state
      row('同意配资')  do 
          link_to t('Agree'), agree_leverage_admin_leverage_path(leverage), :method => :put, :class => 'button' 
      end
      row('拒绝配资')  do 
          link_to t('Deny'), deny_leverage_admin_leverage_path(leverage), :method => :put, :class => 'button' 
      end
      row :interest_id
      row :description
      row :updated_at
      row :created_at
    end
  end

  sidebar "Leverage 通知", only: :show do
    attributes_table_for leverage do 
      row('配资审核通过')  do 
        link_to t('Confirm'), leverage_confirm_inform_admin_leverage_path(leverage), :method => :get, :class => 'button'
      end
      row('配资追加保证金')  do 
        link_to t('Confirm'), add_deposit_inform_admin_leverage_path(leverage), :method => :get, :class => 'button'
      end
      row('配资追缴利息') do
        form_for "",url: add_interests_inform_admin_leverage_path(leverage), method: :post do |f|
            f.text_area :interests
            f.submit
          end
        end  
    end
  end

  form do |f|
    f.inputs do 
      f.input :user_id, as: :select, collection: User.order(:email).map{|u| [u.email, u.id]}
      f.input :date, as: :datepicker
      f.input :amount
      f.input :description
      f.input :duration
      f.input :state, as: :select, collection: ["applied", "confirmed", "closed", "denied"]
      f.input :interest_id
    end
    f.actions
  end


  member_action :agree_leverage, :method => :put do
    leverage = Leverage.find(params[:id])
    if leverage.state == 'applied'
      user = resource.user
      UserMailer.welcome_email(user).deliver_now 
      leverage.confirm
    elsif leverage.state == 'confirmed'
      leverage.close
    end
    redirect_to admin_leverage_path(leverage), notice: "执行成功"
  end

  member_action :deny_leverage, :method => :put do
    leverage = Leverage.find(params[:id])
    if leverage.state = 'applied'
      leverage.deny 
    end
    redirect_to admin_leverage_path(leverage), notice: "执行成功"
  end

  member_action :leverage_confirm_inform, :method => :get do
    flash[:notice] = "发送成功"    
    leverage_inform(resource, 'leverage_confirm_inform')
  end

  member_action :add_deposit_inform, :method => :get do
    flash[:notice] = "发送成功"
    leverage_inform(resource, 'add_deposit_inform')
  end

  member_action :add_interests_inform, :method => :post do
    user = resource.user
    leverage_amount = resource.leverage_amount
    hash = {
      user: user,
      leverage_amount: leverage_amount,
      interests: params[:input][:interests],
      date: resource.created_at.to_date
    }
    UserMailer.leverage_email('add_interests_inform', hash).deliver_now
    resource.send_sms(user.cell, 'add_interests_inform', hash)
    redirect_to admin_leverage_path(resource), notice: "执行成功"
  end


  
end