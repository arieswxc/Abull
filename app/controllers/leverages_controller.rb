class LeveragesController < ApplicationController
  def show
    @leverage = Leverage.find(params[:id])
    @user     = @leverage.user
    @comments = @leverage.comments
  end

  def new
    @leverage = current_user.leverages.build
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
      params.require(:leverage).permit(:user_id, :date, :amount, :description, :deadline, :state)
    end
end