class Profile::InvestsController < ApplicationController
  def index
    @user               = User.find(params[:user_id])
    invests            = @user.invests.order(id: :desc)
    @total_invest_value = invests.sum(:amount)
    @invests            = invests.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @user               = User.find(params[:user_id])
    @invest             = @user.invests.find(params[:id])
    @fund               = @invest.fund
    invests            = @user.invests.order(id: :desc)
    @total_invest_value = @fund.invests.sum(:amount)
    @invests            = invests.paginate(:page => params[:page], :per_page => 10)
    if @user.line_csv && @user.line_csv.file
      list_data = parse_list_data(@user.line_csv.file.current_path)
      @list_array = list_data.last(5).reverse
    end
    @verify_photos = @user.verify_photos
    @fund_verify_photos  = @fund.fund_verify_photos
    if @fund.line_csv && @fund.line_csv.file
      fund_list_data = parse_list_data(@fund.line_csv.file.current_path)
      @fund_list_array = fund_list_data.last(5).reverse
    end
    # if !session[@fund.id].nil?
    #   @flag = @fund.private_check == 'public' ?  true : session[@fund.id]
    # else
    #   @flag = @fund.private_check == 'public' ?  true : false
    # end
    @is_invest = true
    @is_unlock = true
  end

end
