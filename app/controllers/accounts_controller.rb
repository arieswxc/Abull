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
    balance           = current_user.account.balance if current_user
    account           = current_user.account
    @billing_out      = account.billings.build(billing_params)
    @billing_in       = account.billings.build(billing_params)
    @billing_withdraw = account.billings.build(billing_params)
    @billing_out.billing_type       = "From Balance"
    @billing_in.billing_type        = "To Frost"
    @billing_withdraw.billing_type  = "Withdraw"

    account.balance -= @billing_out.amount
    account.frost += @billing_out.amount
    if @billing_out.amount < balance
      ActiveRecord::Base.transaction do
        @billing_out.save
        @billing_in.save
        @billing_withdraw.save
        @billing_out.update(amount: -@billing_out.amount )
        @billing_withdraw.update(amount: -@billing_withdraw.amount)
        account.save
        @billing_out.confirm
        @billing_in.confirm
      end
      redirect_to user_account_billings_path
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
