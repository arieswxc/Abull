class Profile::FundsController < ApplicationController
  def index
    @user             = User.find(params[:user_id])
    @funds            = @user.funds
    @total_fund_value = @funds.sum(:amount)
  end

  def show
    @user               = User.find(params[:user_id])
    @fund               = @user.funds.find(params[:id])
    @invests            = @fund.invests
    @invest = @fund.invests.build()
    @invest.date = Time.now()
    @flag = true
  end
end
