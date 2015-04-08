class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # def parse_csv(current_path)
  #   # if user.line_csv
  #   array_x = []
  #   array_y = []
  #   File.open(current_path, "r") do |file|
  #     file.each_line do |line|
  #       pos_x, pos_y = line.chomp.split(",")
  #       array_x = array_x << pos_x
  #       array_y = array_y << pos_y
  #     end
  #   end
  #   interval = (array_x.length / 10).to_i
  #   array_x.reverse!
  #   0.upto(array_x.length) do |index|
  #     array_x[index] = "" if index % interval != 0
  #   end
    
  #   array_x.reverse!
  #   [array_x, array_y]
  # end
  def parse_csv(current_path)
    # if user.line_csv
    items = []
    File.open(current_path, "r") do |file|
      file.each_line do |line|
        array = line.chomp.split(" ")
        time = array[0].to_time.to_i.to_s + "000"
        time = time.to_i
        data = array[1]
        item = [time, array[1].to_i]
        items << item
      end
    end
    items
  end

  def parse_list_data(current_path)
    array = []
    if current_path
      begin
        File.open(current_path, "r") do |file|
          file.each_line do |line|
            pos_x, pos_y = line.chomp.split(",")
            array = array << [pos_x, pos_y]
          end
        end

      rescue
        array =[]
      end
    end
    array
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:cell, :username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:cell, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :abstract) }
  end
end
