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
    @flag = @fund.private_check == 'public' ?  true : session[:private_check]
  end

  def create
    @fund   = Fund.find(params[:fund_id])
    @invest = @fund.invests.build(invest_params)
    @invests = @fund.invests
    flag = @fund.private_check == 'public' ?  true : session[:private_check]

    if @fund.state == "gathering" && (@fund.raised_amount + params[:invest][:amount].to_i <= @fund.amount) && flag && @invest.save
      current_user.follow(@fund.user)
      @invest.update(user_id: current_user.id)
      redirect_to fund_invest_path(@fund, @invest)
    else
      render :new
    end
  end

  def unlock
    fund = Fund.find(params[:fund_id])
    if fund && fund.private_check == 'private' &&fund.private_code.to_i == params[:private_code].to_i
      session[:private_check] = true
      render json: { check: 'true' }
    else
      session[:private_check] = false
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
