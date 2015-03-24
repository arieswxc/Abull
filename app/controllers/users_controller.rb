class UsersController < ApplicationController
  after_action :send_email, only: [:create]

  def investor_apply
    @user = User.find(params[:id])
  end

  def trader_apply
    @user = User.find(params[:id])
  end

  def investor_applied
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        @user.investor_apply
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :investor_apply }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def trader_applied
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        @user.trader_apply
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :trader_apply }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @user             = User.find(params[:id])
    @funds            = @user.funds
    @invests          = @user.invests
    @leverages        = @user.leverages
    @topics           = Topic.where(user_id: @user.following_users.ids)
    @recommend_funds  = Fund.where(user_id: @user.following_users.ids)
  end

  def save_avatar
    @user = User.find(params[:id])
    @user.avatar = params[:avatar]
    if @user.save 
      render json: {message: "success"}
    else
      render json: {message: "fail"}
    end
  end

  def generate_verification_code
    code      = rand(100000..999999)
    session[:code] = code
    batch_code  = send_sms(code, params[:cell])

    if batch_code
      render json: {message: 'success'}
    else
      render json: {error: 'failed'}
    end
  end

  


  private
    def user_params
      params.require(:user).permit(
        :real_name, :id_card_number, :email, :password, :username, 
        :birthday, :gender, :education, :address, :job, :cell,
        photos_attributes: [:id, :title, :photo, :destroy])
    end

    def send_email
      @user = current_user
      UserMailer.welcome_email(@user).deliver_now
    end

    def send_sms(code, cell)
      uri       = URI.parse("http://222.73.117.158/msg/HttpSendSM")
      msg       = "欢迎注册摩尔街账户，您的激活码为#{code},请在注册页面填写"
      username  = 'jiekou-cs-01'
      password  = 'Tch147259'
  
      res = Net::HTTP.post_form(uri, account: username, pswd: password, mobile: cell, msg: msg, needstatus: true)
      res.body.split[1]
    end



end