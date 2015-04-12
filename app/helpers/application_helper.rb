module ApplicationHelper
  def check_user(user)
    [ "risk_controller", "customer_service", "admin" ].include?(user.role) ? true : false
  end
  def inform(resource, type, amount)
    user = resource.user
    UserMailer.account_email(user, type, amount).deliver_now
    hash = {
      name: user.real_name,
      amount: amount
    }
    resource.send_sms(user.cell, type, hash) if user.email
    redirect_to admin_account_path(resource)
  end

  def fund_inform(resource, type)
    user = resource.user
    fund_name = resource.name
    hash = {
      user: user,
      fund_name: fund_name,
      date: resource.created_at.to_date
    }
    UserMailer.fund_email(type, hash).deliver_now if user.email
    resource.send_sms(user.cell, type, hash)
    redirect_to admin_fund_path(resource)
  end

  def leverage_inform(resource, type)
    user = resource.user
    leverage_amount = resource.leverage_amount
    hash = {
      user: user,
      leverage_amount: leverage_amount,
      date: resource.created_at.to_date
    }
    UserMailer.leverage_email(type, hash).deliver_now
    resource.send_sms(user.cell, type, hash)
    redirect_to admin_leverage_path(resource)
  end

  def invest_inform(resource, type)
    user = resource.user
    fund_name = resource.fund.name
    hash = {
      user: user,
      fund_name: fund_name,
      date: resource.created_at.to_date
    }
    UserMailer.invest_email(type, hash).deliver_now if user.email
    resource.send_sms(user.cell, type, hash)
    redirect_to admin_invest_path(resource)
  end

  def check_private(resource, private = 'private')
    if resource && private == "private"
      resource = resource.length > 1 ? resource.first(1) + "*" * (resource.length - 1) : "***"
      # resource.first(3) + tmps
    else
      resource
    end
  end

end
