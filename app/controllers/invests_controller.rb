class InvestsController < ApplicationController
  before_action :authenticate_user!, only: [:create,:edit]
  # before_action :check_invest_user, only: [:new, :create]
  # after_action :authenticate_user!, only: [:new]
  def index
    @fund         = Fund.find(params[:fund_id])
    @invests      = @fund.invests
    @fund_balance = @fund.amount - @invests.sum(:amount)
  end

  def new
    @fund   = Fund.find(params[:fund_id])
    invests = @fund.invests.order(date: :desc)
    @total_invest_value = invests.sum(:amount)
    @invests = invests.paginate(:page => params[:page], :per_page => 10)
    @invest = @fund.invests.build()
    @invest.date = Time.now()
    user = User.find(@fund.user_id)

    if user.line_csv && user.line_csv.file
      list_data = parse_list_data(user.line_csv.file.current_path)
      @list_array = list_data.last(5).reverse
    end

    # 判断是非投过
    @is_invest = false
    @is_invest = @fund.check_user_bid(current_user) if current_user


    # 判断是非解锁
    @is_unlock = @fund.private_check == 'public' ?  true : false
    @is_unlock = true if session[@fund.id] or @is_invest

    # @flag = true if current_user && @fund.check_user_bid(current_user)

    @verify_photos = user.verify_photos

    if @fund.line_csv && @fund.line_csv.file
      fund_list_data = parse_list_data(@fund.line_csv.file.current_path)
      @fund_list_array = fund_list_data.last(5).reverse
    end
    @fund_verify_photos  = @fund.fund_verify_photos
    @check_user_bid = @fund.check_user_bid(current_user).to_s
  end

  def show
    @fund = Fund.find(params[:fund_id])
    user = User.find(@fund.user_id)
    if user.line_csv && user.line_csv.file.current_path
      list_data = parse_list_data(user.line_csv.file.current_path)
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
    flag = @fund.check_user_bid(current_user) if flag != true
    flag = true if @fund.user_id == current_user.id
    if @fund.state == "gathering" && (@fund.raised_amount + params[:invest][:amount].to_i <= @fund.amount) && (params[:invest][:amount].to_f <= current_user.account.balance) && flag && @invest.save
      current_user.follow(@fund.user)
      @invest.update(user_id: current_user.id)
      invest_account  = current_user.account
      fund_account    = @fund.fund_account
      billing_out = Billing.new(
        account_id:   invest_account.id,
        amount:       -@invest.amount,
        billing_type: "投标成功",
        billable:     @invest,
        remark:       @fund.name)
      billing_in = Billing.new(
        account_id:   fund_account.fund.user.account.id,
        amount:       @invest.amount,
        billing_type: "获得投标",
        billable:     @fund)
      invest_account.balance -= @invest.amount
      fund_account.balance += @invest.amount
      ActiveRecord::Base.transaction do
        billing_in.save
        billing_out.save
        invest_account.save
        fund_account.save
      end
      billing_in.confirm
      billing_out.confirm
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
