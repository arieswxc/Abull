class FundsController < ApplicationController
  def index
    @q      = Fund.search(params[:q])
    @funds  = @q.result
  end

  def show
    @fund     = Fund.find(params[:id])
    @private  = @fund.private_check
    @user     = @fund.user
    @comments = @fund.comments
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
        :name, :amount, :collection_deadline,
        :private_check, :minimum, :invest_starting_date,
        :invest_ending_date, :expected_earning_rate, :description,
        :frontend_risk_method, :backend_risk_method, :homs_account, :initial_amount, :state)
    end
end