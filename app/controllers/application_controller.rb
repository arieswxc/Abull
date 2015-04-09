class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def access_denied(exception)
    redirect_to admin_dashboard_path, alert: exception.message
  end

  def parse_csv(data_path)
    items = []
    other_data = []
    hushen_data = []
    hushen300_path = "#{Rails.root}/lib/LibFile/hs300_data.csv"
    initial_value = 0

    File.open(data_path, "r") do |file|
      file.each_line.with_index do |line, index|
        array = line.chomp.split(",")
        initial_value = array[1].to_f if index == 0
        time = array[0].to_time.to_i.to_s + "000"
        time = time.to_i
        data = (array[1].to_f / initial_value)
        item = [time, data]
        other_data << item
      end
    end

    begin_date = Time.at(other_data.first[0].to_s.slice(0, other_data.first[0].to_s.length - 3).to_i)
    end_date = Time.at(other_data.last[0].to_s.slice(0, other_data.last[0].to_s.length - 3).to_i)

    flag = 0

    File.open(hushen300_path, "r") do |file|
      file.each_line.with_index do |line, index|
        array = line.chomp.split(" ")
        initial_value = array[1].to_f if index == 0
        
        if array[0].to_time >= begin_date && flag == 0 .. array[0].to_time > end_date
          time = array[0].to_time.to_i.to_s + "000"
          time = time.to_i
          data = array[1].to_f / initial_value
          item = [time, data]
          hushen_data << item
          flag = 1 if array[0].to_time > end_date
        end
      end
    end
    
    [other_data,hushen_data]
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
