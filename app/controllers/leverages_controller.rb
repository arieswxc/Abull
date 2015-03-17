class LeveragesController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit]
  def show
    @leverage   = Leverage.find(params[:id])
    @user       = @leverage.user
    @comments   = @leverage.comments
    # @interests  = Interest.where(show: "true")
  end

  def new
    @leverage = current_user.leverages.build
    # @interests  = Interest.where(show: "true")
    @leverage.user_id = current_user.id
  end

  def create
    @leverage = current_user.leverages.build(leverage_params)
    # @interests  = Interest.where(show: "true")
    @leverage.interest_id = Interest.where("amount = ? and leverage_time = ? and duration = ?", params[:leverage][:amount], params[:leverage][:leverage_time], params[:leverage][:duration]).first.id
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

  def query_rate
    amount = params[:amount].blank? ? 2000 : params[:amount]
    leverage_time = params[:leverage_time].blank? ? 5 : params[:leverage_time]
    duration = params[:duration].blank? ? 1 : params[:duration]

    rate = Interest.query(amount, leverage_time, duration)
    total_amount = amount.to_f * (leverage_time.to_f + 1)
    loss_warning_line = (total_amount * 0.9).to_i
    loss_making_line = (total_amount * 0.87).to_i
    total_interests = total_amount * leverage_time.to_f * rate / 100

    render json: {rate: rate, total_amount: total_amount, loss_making_line: loss_warning_line, loss_warning_line: loss_warning_line, total_interests: total_interests}
  end

  private
    def leverage_params
      params.require(:leverage).permit(:user_id, :date, :amount, :description, :duration, :state)
    end
end
