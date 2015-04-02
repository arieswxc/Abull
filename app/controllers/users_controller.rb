class UsersController < ApplicationController
  after_action :send_email, only: [:create]
  before_action :authenticate_user!, except: [:generate_verification_code, :update_password, :get_history_data]

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
    @funds            = @user.funds.order(created_at: :desc)
    @invests          = @user.invests.order(created_at: :desc)
    @leverages        = @user.leverages
    @topics           = Topic.where(user_id: @user.following_users.ids)
    @recommend_funds  = Fund.where(user_id: @user.following_users.ids)
    funds_hash, invests_hash = @user.funds_and_invests_data
    respond_to do |format|
      format.html { render :show }
      format.json { render json:
        {
          fund_data:{
            labels: funds_hash.keys,
            data: funds_hash.values
          },
          invest_data:{
            labels: invests_hash.keys,
            data: invests.values
          },
        }
      }
    end
  end

  def save_avatar
    @user = User.find(params[:id])
    @user.avatar = parse_image_data(params[:avatar]) if params[:avatar]
    # @user.avatar = params[:avatar]
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

  #忘记密码，短信发送新密码接口
  def update_password
    user = User.find_by(cell: params[:user][:cell].to_i)
    if user
      user.reset_password(params[:user][:cell])
    end
    redirect_to root_path
  end

  #用户登录后手动更新密码页面
  def edit_password
    @user = current_user
  end

  #用户登录后手动更新密码接口
  def reset_password
    @user = User.find(current_user.id)
    if @user.update_with_password(user_password_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      redirect_to edit_user_registration_path
    end
  end

  def get_chart_data
    @user = User.find(params[:id])
    funds_hash, invests_hash = @user.funds_and_invests_data
    render json:{
        fund_data:{
          labels: funds_hash.keys,
          data: funds_hash.values
        },
        invest_data:{
          labels: invests_hash.keys,
          data: invests_hash.values
        },
      }
  end

  def get_history_data
    user = User.find(params[:id])
    if user.line_csv &&user.line_csv.file.current_path
      array_x, array_y = parse_csv(user.line_csv.file.current_path)
      current_path = "#{Rails.root}/lib/LibFile/husheng_data.csv"
      array1_x, array1_y = parse_csv(current_path)
      render json:{ labels: array_x, datasets: [{data: array_y}, {data: array1_y}] }
    else
      render json:{ message: "Not found" }, status: 404
    end
  end

  def show_history_data
    user = User.find(params[:id])
    if user.line_csv && user.line_csv.file.current_path
      @list_data = parse_list_data(user.line_csv.file.current_path)
    end
  end

  def cashin

  end

  def cashout

  end

  private
    def user_params
      params.require(:user).permit(
        :real_name, :id_card_number, :email, :password, :username,
        :birthday, :gender, :education, :address, :job, :cell, :education_photo, :address_photo,
        identity_photos_attributes: [:id, :title, :photo, :destroy])
    end

    def user_password_params
      params.required(:user).permit(:password, :password_confirmation, :current_password)
    end

    def send_email
      @user = current_user
      UserMailer.welcome_email(@user).deliver_now
    end

    def send_sms(code, cell)
      uri       = URI.parse("http://222.73.117.158:80/msg/HttpBatchSendSM")
      msg       = "欢迎注册摩尔街账户，您的激活码为#{code},请在注册页面填写【bull】"
      username  = 'zxnicv'
      password  = 'Txb123456'
      puts "激活码为 #{code}"
      res = Net::HTTP.post_form(uri, account: username, pswd: password, mobile: cell, msg: msg, needstatus: true)
      res.body.split[1]
    end

    def parse_image_data(base64_image)
      filename = Digest::SHA1.hexdigest(Time.now.to_s + base64_image[0,100])
      in_content_type, encoding, string = base64_image.split(/[:;,]/)[1..3]

      @tempfile = Tempfile.new(filename)
      @tempfile.binmode
      @tempfile.write Base64.decode64(string)
      @tempfile.rewind

    # for security we want the actual content type, not just what was passed in
      content_type = `file --mime -b #{@tempfile.path}`.split(";")[0]

    # we will also add the extension ourselves based on the above
    # if it's not gif/jpeg/png, it will fail the validation in the upload model
      extension = content_type.match(/gif|jpeg|png/).to_s
      filename += ".#{extension}" if extension

      ActionDispatch::Http::UploadedFile.new({
        tempfile: @tempfile,
        content_type: content_type,
        filename: filename
      })
    end

end
