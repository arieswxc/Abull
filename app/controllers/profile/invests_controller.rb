class Profile::InvestsController < ApplicationController
  def index
    @user               = User.find(params[:user_id])
    @invests            = @user.invests
    @total_invest_value = @invests.sum(:amount)
  end

  def show
    @user               = User.find(params[:user_id])
    @invest             = @user.invests.find(params[:id])
    @fund               = @invest.fund
    @invests            = @user.invests
    list_data = parse_list_data(@user.line_csv.current_path)
    @list_array = list_data.last(5).reverse
    @verify_photos = @user.verify_photos
    @fund_verify_photos  = @fund.fund_verify_photos
  end

end
