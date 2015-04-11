class Profile::FundsController < ApplicationController
  def index
    @user             = User.find(params[:user_id])
    funds            = @user.funds
    @total_fund_value = funds.sum(:amount)
    @funds          = funds.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @user               = User.find(params[:user_id])
    @fund               = @user.funds.find(params[:id])
    invests            = @fund.invests
    @total_invest_value = invests.sum(:amount)
    @invests            = invests.paginate(:page => params[:page], :per_page => 10)
    @invest = @fund.invests.build()
    @invest.date = Time.now()
    @is_invest = true
    @is_unlock = true
  end
end
