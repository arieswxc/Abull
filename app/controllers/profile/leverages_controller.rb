class Profile::LeveragesController < ApplicationController
  def index
    @user                 = User.find(params[:user_id])
    @leverages            = @user.leverages
    @total_leverage_value = @leverages.sum(:amount)
  end
end