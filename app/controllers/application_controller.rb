class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # def parse_csv(current_path)
  #   # if user.line_csv
  #   items = []
  #   File.open(current_path, "r") do |file|
  #     file.each_line do |line|
  #       array = line.chomp.split(" ")
  #       time = array[0].to_time.to_i.to_s + "000"
  #       time = time.to_i
  #       data = array[1]
  #       item = [time, array[1].to_i]
  #       items << item
  #     end
  #   end
  #   items
  # end

  def parse_csv(data_path)
    items = []
    hushen300_path = "#{Rails.root}/lib/LibFile/husheng_data.csv"
    
    File.open(data_path, "r") do |file|
      file.each_line do |line|
        array = line.chomp.split(",")
        time = array[0].to_time.to_i.to_s + "000"
        time = time.to_i
        data = array[1]
        item = [time, array[1].to_i]
        data << item
      end
    end

    begin_date = Time.at(data.first[0]).to_date
    end_date = Time.at(data.last[0]).to_date

    
    File.open(hushen300_path, "r") do |file|
      file.each_line do |line|
        array = line.chomp.split(" ")
        if array[0].to_date >= begin_date .. array[0].to_date <= end_date
          time = array[0].to_time.to_i.to_s + "000"
          time = time.to_i
          data = array[1]
          item = [time, array[1].to_i]
          hushen_data << item
        end
      end
    end
    
    [data,hushen_data]
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
