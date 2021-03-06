class LeveragesController < ApplicationController
  before_action :authenticate_user!, only: [:create,:edit]
  def show
    @leverage   = Leverage.find(params[:id])
    @user       = @leverage.user
    @comments   = @leverage.comments
  end

  def new
    @leverage = Leverage.new
  end

  def create
    @leverage = current_user.leverages.build(leverage_params)
    @leverage.interest_id = Interest.query(params[:leverage][:amount], params[:leverage_time], params[:leverage][:duration]).id
    if @leverage.save
      @leverage.save_interest
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
    interest = Interest.query(amount, leverage_time, duration)
    rate = interest.interest_rate
    total_amount = amount.to_f * (leverage_time.to_f + 1)
    loss_warning_line = (total_amount * 0.9).to_i
    loss_making_line = (total_amount * 0.87).to_i
    total_interests = total_amount * leverage_time.to_f * rate / 100
    render json: {rate: rate, total_amount: total_amount, loss_making_line: loss_warning_line, loss_warning_line: loss_warning_line, total_interests: total_interests}
  end

  private
    def leverage_params
      params.require(:leverage).permit(:user_id, :amount, :description, :duration, :state)
    end

end
