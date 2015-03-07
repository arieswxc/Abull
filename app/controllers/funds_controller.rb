class FundsController < ApplicationController
  def index
    @user             = User.find(params[:user_id])
    @funds            = @user.funds
    @total_fund_value = @funds.sum(:amount)
  end
end