class InvestsController < ApplicationController
  before_action :authenticate_user!, only: [:create,:edit]
  # before_action :check_invest_user, only: [:new, :create]
  after_action :authenticate_user!, only: [:new]
  def index
    @fund         = Fund.find(params[:fund_id])
    @invests      = @fund.invests
    @fund_balance = @fund.amount - @invests.sum(:amount)
  end

  def new
    @fund   = Fund.find(params[:fund_id])
    @invests = @fund.invests
    @invest = @fund.invests.build()
    @invest.date = Time.now()
  end

  def create
    @fund   = Fund.find(params[:fund_id])
    @invest = @fund.invests.build(invest_params)
    @invests = @fund.invests
    if @fund.state == "gathering" && (@fund.raised_amount + params[:invest][:amount].to_i <= @fund.amount) && session[:private_check] == 'true' && @invest.save
      current_user.follow(@fund.user)
      @invest.update(user_id: current_user.id)
      redirect_to fund_invest_path(@fund, @invest)
    else
      # flash[:error] = "投标的金额超过该标剩余的额度，请重填" if @fund.raised_amount > @fund.amount
      render :new
    end
  end

  def unlock
    fund = Fund.find(params[:fund_id])
    # fund = current_user.funds.find_by(private_code: params[:private_code])
    if fund && fund.private_check == 'private' &&fund.private_code.to_i == params[:private_code].to_i
      session[:private_check] = 'true'
      render json: { check: 'true' }
    else
      session[:private_check] = 'false'
      render json: { check: 'false' }
    end
  end


  private
    def invest_params
      params.require(:invest).permit(:user_id, :fund_id, :amount, :date, :payback, :close_day)
    end

    def check_invest_user
      if current_user.level == 'unverified'
        render json: { message: '请进行用户身份验证' }
      elsif current_user.level == 'investor_applied'
        render json: { message: '用户身份尚在验证' }
      end
    end

end
