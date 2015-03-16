class InvestsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit]
  def index
    @fund         = Fund.find(params[:fund_id])
    @invests      = @fund.invests
    @fund_balance = @fund.amount - @invests.sum(:amount)
  end

  def new
    @fund   = Fund.find(params[:fund_id])
    @invest = @fund.invests.build()
    @invest.user_id = current_user.id 
    @invest.date = Time.now()
  end

  def create
    @fund   = Fund.find(params[:fund_id])
    @invest = @fund.invests.build(invest_params)

    if @fund.state == "gathering" && @fund.raised_amount <= @fund.amount && @invest.save
      @invest.user.follow(@fund.user)
      redirect_to fund_invest_path(@fund, @invest)
    else
      # flash[:error] = "投标的金额超过该标剩余的额度，请重填" if @fund.raised_amount > @fund.amount
      render :new
    end
  end

  private
    def invest_params
      params.require(:invest).permit(:user_id, :fund_id, :amount, :date, :payback, :close_day)
    end
end
