class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  def parse_csv(current_path)
    # if user.line_csv
    array_x = []
    array_y = []
    File.open(current_path, "r") do |file|
      file.each_line do |line|
        pos_x, pos_y = line.chomp.split(",")
        array_x = array_x << pos_x
        array_y = array_y << pos_y
      end
    end
    [array_x, array_y]
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:cell, :username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:cell, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:cell, :username, :email, :password, :password_confirmation, :current_password, :real_name) }
  end
end
