class FundsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit]
  # before_action :check_fund_user, only: [:new, :create]
  def index
    # @q      = Fund.search(params[:q])
    # @funds  = @q.result
    @funds = Fund.search_by_conditions(params[:duration], params[:amount], params[:deadline]).where("state = 'gathering' or state = 'reached'").order('created_at')
  end

  def show
    @fund             = Fund.find(params[:id])
    @private          = @fund.private_check
    @user             = @fund.user
    @comments         = @fund.comments
    @rate_of_progress = (@fund.amount == 0 || @fund == nil) ? "undefined" : ((@fund.invests.sum(:amount) * 100) / @fund.amount )
  end

  def new
    @fund = current_user.funds.build()
  end

  def create
    @fund = current_user.funds.build(fund_params)
    if @fund.save
      redirect_to @fund
    else
      render 'new'
    end
  end

  def edit
    @fund = current_user.funds.find(params[:id])
  end

  def update
    @fund = current_user.funds.find(params[:id])
    if @fund.update(fund_params)
      redirect_to @fund
    else
      render 'edit'
    end
  end

  private
    def fund_params
      params.require(:fund).permit(
        :name, :amount, :ending_days,
        :private_check, :minimum, :invest_starting_date,
        :duration, :expected_earning_rate, :description,
        :frontend_risk_method, :backend_risk_method, :homs_account, :initial_amount, :state)
    end

    def check_fund_user
      if current_user.level == 'unverified'
        render json: { message: '请进行用户身份验证' }
      elsif current_user.level == 'investor'
        render json: { message: '请填写trader申请资料'}
      elsif current_user.level == 'trader_appiled'
        render json: { message: '申请trader资料尚在审核' }
      end
    end
end
