class Profile::InvestsController < ApplicationController
  def index
    @user               = User.find(params[:user_id])
    @invests            = @user.invests
    @total_invest_value = @invests.sum(:amount)
  end
end