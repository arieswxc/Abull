class FundsController < ApplicationController
  before_action :authenticate_user!, only: [:create,:edit]
  # before_action :check_fund_user, only: [:new, :create]
  after_action :generate_private_code, only: [:create]
  after_action :authenticate_user!, only: [:new]
  def index
    # @q      = Fund.search(params[:q])
    # @funds  = @q.result
    funds = Fund.search_by_conditions(params[:duration], params[:amount], params[:expected_earning_rate], params[:private_check]).where(state: ['gathering', 'reached', 'running', 'finished', 'closed']).order(state: :asc, created_at: :desc)
    @total_fund_value = funds.sum(:amount)
    @funds          = funds.paginate(:page => params[:page], :per_page => 10)
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
      @fund.create_fund_account
      @fund.apply
      @fund.create_homs_account(title: "undefined")
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

  def get_history_data
    fund = Fund.find(params[:id])
    if fund.line_csv && fund.line_csv.file.current_path
      hushen_data, fund_data = parse_csv(fund.line_csv.file.current_path)
      render json:[{data: hushen_data}, {data: fund_data}]
    else
      render json:{ message: "Not found" }, status: 404
    end
  end

  def show_history_data
    fund = Fund.find(params[:id])
    if fund.line_csv && fund.line_csv.file.current_path
      @list_data = parse_list_data(fund.line_csv.file.current_path)
    end
  end

  private
    def fund_params
      params.require(:fund).permit(
        :name, :amount, :ending_days,
        :private_check, :minimum, :invest_starting_date,
        :duration, :expected_earning_rate, :description,
        :frontend_risk_method, :backend_risk_method, :homs_account,
        :initial_amount, :state, :management_fee)
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
        fund.private_code = rand(100000..999999)
        fund.save
      end
    end

end
