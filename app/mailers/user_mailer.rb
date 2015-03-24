class UserMailer < ApplicationMailer
  default from: 'xianjieo@163.com'

  def account_email(user, type, amount)
    params = {
      user: user,
      amount: amount
    }
    case type 
    when 'offline'
      subject = "线下充值通知"
    when 'zhifubao'
      subject = "支付宝充值通知"
    when 'withdraw'
      subject = "提现通知"
    end 
            
    mail(to: user.email, subject: subject) do |format|
      format.html { render type, locals: params }
    end
  end

  def fund_email(type, params)
    case type 
    when 'fund_confirm_inform'
      subject = "发标审核通过"
    when 'fund_deny_inform'
      subject = "发标审核未通过"
    when 'fund_liquidation_inform'
      subject = "发标提前清盘"
    end 
    user = params[:user]
    mail(to: user.email, subject: subject) do |format|
      format.html { render type, locals: params }
    end
  end

  def leverage_email(type, params)
    case type 
    when 'leverage_confirm_inform'
      subject = "配资审核通过通知"
    when 'add_deposit_inform'
      subject = "配资追加保证金通知"
    when 'add_interests_inform'
      subject = "配资追缴利息通知"
    end 
    user = params[:user]
    mail(to: user.email, subject: subject) do |format|
      format.html { render type, locals: params }
    end
  end

  def invest_email(type, params)
    case type 
    when 'advanced_liquidation'
      subject = "投标提前清盘通知"
    when 'due_liquidation'
      subject = "投标到期清盘通知"
    end 
    user = params[:user]
    mail(to: user.email, subject: subject) do |format|
      format.html { render type, locals: params }
    end
  end




end