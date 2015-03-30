ActiveAdmin.register Billing do
  permit_params :account_id, :amount, :billing_type, :billable_type, :billable_id, :state

  show do |billing|
    attributes_table do
      row :id
      row :account_id
      row :amount
      row :billing_type
      row :billable_type
      row :billable_id
      row :state
    end
  end

  sidebar "State", only: :show do
    attributes_table_for billing do
      row :state
      row('Confirm')  do 
          link_to t('Confirm'), confirm_admin_billing_path(billing), :method => :put, :class => 'button' 
      end
      row('Deny')  do 
          link_to t('Deny'), deny_admin_billing_path(billing), :method => :put, :class => 'button' 
      end
    end
  end

  member_action :confirm, :method => :put do
    billing = Billing.find(params[:id])
    account = billing.account
    if billing.billing_type == "Withdraw"
      account.frost += billing.amount
    else
      account.balance += billing.amount
    end
    ActiveRecord::Base.transaction do
      billing.confirm
      account.save
    end
    redirect_to admin_billing_path(billing)
  end

  member_action :deny, :method => :put do
    billing = Billing.find(params[:id])
    billing.deny
    redirect_to admin_billing_path(billing)
  end
end