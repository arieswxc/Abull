module ApplicationHelper
  def check_user(user)
    [ "risk_controller", "customer_service" ].include?(user.role) ? true : false
  end
  def inform(resource, type, amount)
    user = resource.user
    UserMailer.welcome_email(user).deliver_now
    hash = {
      name: user.real_name,
      amount: amount
    }
    resource.send_sms(user.cell, type, hash)
    redirect_to admin_account_path(resource)
  end

  def fund_inform(resource, type)
    user = resource.user
    fund_name = resource.name
    UserMailer.welcome_email(user).deliver_now
    hash = {
      name: user.real_name,
      fund_name: fund_name,
      date: resource.created_at.to_date
    }
    resource.send_sms(user.cell, type, hash)
    redirect_to admin_fund_path(resource)
  end

  def leverage_inform(resource, type)
    user = resource.user
    leverage_amount = resource.leverage_amount
    UserMailer.welcome_email(user).deliver_now
    hash = {
      name: user.real_name,
      leverage_amount: leverage_amount,
      date: resource.created_at.to_date
    }
    resource.send_sms(user.cell, type, hash)
    redirect_to admin_leverage_path(resource)
  end


end
