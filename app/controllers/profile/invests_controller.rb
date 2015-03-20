class Profile::InvestsController < ApplicationController
  def index
    @user               = User.find(params[:user_id])
    @invests            = @user.invests
    @total_invest_value = @invests.sum(:amount)
  end

  def show
    @user               = User.find(params[:user_id])
    @invest             = @user.invests.find(params[:id])
    @fund               = @invest.fund
    @invests            = @user.invests
  end

end
