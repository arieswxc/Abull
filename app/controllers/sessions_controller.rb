class SessionsController < Devise::SessionsController
  def new
    super
  end

  # POST /resource/sign_in
  def create
    set_flash_message(:error, "valid username or password") unless User.find_by(cell: params[:user][:cell]) && User.find_by(cell: params[:user][:cell]).valid_password?(params[:user][:password])
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    # set_flash_message(:error, "登录名或密码错误") if resource.valid_password?(params[user[password]])
    # flash[:error] =  "登录名或密码错误"
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end
end
