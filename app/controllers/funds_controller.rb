class FundsController < ApplicationController
  before_action :authenticate_user!, only: [:create,:edit]
  # before_action :check_fund_user, only: [:new, :create]
  after_action :generate_private_code, only: [:create]
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
    @fund = Fund.new
  end

  def create
    @fund = current_user.funds.build(fund_params)
    if @fund.save
      @user = current_user
      UserMailer.welcome_email(@user).deliver_now
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

    def generate_private_code
      fund = current_user.funds.last
      if fund && fund.private_check == 'private'
        fund.private_code = rand(999999)
        fund.save
      end
    end

end
