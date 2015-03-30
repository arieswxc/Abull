class AccountsController < ApplicationController
  def bankcard_charge
    @billing = Billing.new
  end

  def bankcard_charged
    @billing = current_user.account.billings.build(billing_params)
    if @billing.save
      redirect_to user_account_billings_path
    else
      render 'bankcard_charge'
    end
  end

  def alipay_charge
    @billing = Billing.new
  end

  def alipay_charged
    @billing = current_user.account.billings.build(billing_params)
    @billing.billing_type = "Alipay " + @billing.billing_type
    if @billing.save
      # redirect_to user_account_billings_path
      render json: {message: "seccess"}
    else
      render json: {message: "fail"}
    end
  end

  def third_charge
    @billing = Billing.new
  end

  def third_charged
    @billing = current_user.account.billings.build(billing_params)
    @billing.billing_type = "Third"
    if @billing.save
      redirect_to user_account_billings_path
    else
      render 'alipay_charge'
    end
  end

  def withdraw
    @billing = Billing.new
  end

  def withdrawn
    balance = current_user.account.balance if current_user
    @billing = current_user.account.billings.build(billing_params)
    @billing.billing_type = "Withdraw"
    if @billing.amount < balance
      if @billing.save
        @billing.update(amount: -@billing.amount )
        redirect_to user_account_billings_path
      else
        render 'withdrawn'
      end
    else
      flash[:notice] = "没有足够余额"
      render 'withdraw'
    end
  end

  private
    def billing_params
      params.require(:billing).permit(:amount, :billing_type, :billable_id, :billable_type)
    end
end
