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
    user = User.find(@fund.user_id)
    list_data = parse_list_data(user.line_csv.current_path)
    @list_array = list_data.last(5).reverse
    if !session[@fund.id].nil?
      @flag = @fund.private_check == 'public' ?  true : session[@fund.id]
    else
      @flag = @fund.private_check == 'public' ?  true : false
    end
    @verify_photos = user.verify_photos
  end

  def show
    @fund = Fund.find(params[:fund_id])
    user = User.find(@fund.user_id)
    if user.line_csv
      list_data = parse_list_data(user.line_csv.current_path) 
      @list_array = list_data.last(5).reverse
    else
      @list_array = []
    end
    @verify_photos = user.verify_photos
  end

  def create
    @fund   = Fund.find(params[:fund_id])
    @invest = @fund.invests.build(invest_params)
    @invests = @fund.invests
    flag = @fund.private_check == 'public' ?  true : session[@fund.id]

    if @fund.state == "gathering" && (@fund.raised_amount + params[:invest][:amount].to_i <= @fund.amount) && flag && @invest.save
      current_user.follow(@fund.user)
      @invest.update(user_id: current_user.id)
      @invest.check_reached
      redirect_to fund_invest_path(@fund, @invest)
    else
      render :new
    end
  end

  def unlock
    fund = Fund.find(params[:fund_id])
    if fund && fund.private_check == 'private' &&fund.private_code.to_i == params[:private_code].to_i
      session[fund.id] = true
      render json: { check: 'true' }
    else
      session[fund.id] = false
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
