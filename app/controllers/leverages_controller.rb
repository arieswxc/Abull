class LeveragesController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit]
  def show
    @leverage   = Leverage.find(params[:id])
    @user       = @leverage.user
    @comments   = @leverage.comments
    @interests  = Interest.where(show: "true")
  end

  def new
    @leverage = current_user.leverages.build
    @interests  = Interest.where(show: "true")
    @leverage.user_id = current_user.id
  end

  def create
    @leverage = current_user.leverages.build(leverage_params)
    if @leverage.save
      redirect_to @leverage
    else
      render :new
    end
  end

  def edit
    @leverage = current_user.leverages.find(params[:id])
    @interests  = Interest.where(show: "true")
  end

  def update
    @leverage = current_user.leverages.find(params[:id])
    if @leverage.update(leverage_params)
      redirect_to @leverage
    else
      render 'edit'
    end
  end

  private
    def leverage_params
      params.require(:leverage).permit(:user_id, :date, :amount, :description, :deadline, :state, :interest_id)
    end
end
