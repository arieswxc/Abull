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
        #容错处理
        break if line.blank?

        array = line.chomp.split(" ")
        initial_value = array[1].to_f if array[0].to_time == begin_date

        if array[0].to_time >= begin_date && flag == 0 .. array[0].to_time >= end_date
          time = array[0].to_time.to_i.to_s + "000"
          time = time.to_i
          data = array[1].to_f / initial_value
          item = [time, data]
          hushen_data << item
          flag = 1 if array[0].to_time >= end_date
        end
      end
    end
    
    hs_data = []
    other_data.each do |a|
      hushen_data.each do |b|
        if b[0] == a[0]
          hs_data << b
          break
        end
      end
    end
    
    [other_data,hs_data]
  end

  def parse_list_data(current_path)
    array = []
    arrays = []
    if current_path
      begin       
      File.open(current_path, "r") do |file|
          file.each_line do |line|
            pos_x, pos_y = line.chomp.split(",")
            array = array << [pos_x, pos_y]
          end
        end
        initial_value = array[0][1].to_f
        (array.length - 1).downto(1) do |i|
          rate = (((array[i][1].to_f / array[i-1][1].to_f - 1) * 10000).round.to_f / 100).to_s + "%"
          array[i][1] = ((array[i][1].to_f / initial_value) * 100).round / 100.to_f
          arrays << [array[i][0], array[i][1], rate]
        end
        array[0][1] = 1
        arrays << [array[0][0], array[0][1], 0]
        arrays.reverse
      rescue
        array =[]
      end
    end
  end

  def parse_fund_csv(fund)
    items = []
    other_data = []
    hushen_data = []
    hushen300_path = "#{Rails.root}/lib/LibFile/hs300_data.csv"
    initial_value = 0
    
    #解析fund账户
    fund.homs_account.homs_properties.order(date: :asc).each_with_index do |i, index|
      initial_value = i.amount.to_f if index == 0
      time = i.date.to_time.to_i.to_s + "000"
      time = time.to_i
      data = i.amount.to_f / initial_value
      item = [time, data]
      other_data << item
    end
   
    begin_date = Time.at(other_data.first[0].to_s.slice(0, other_data.first[0].to_s.length - 3).to_i)
    end_date = Time.at(other_data.last[0].to_s.slice(0, other_data.last[0].to_s.length - 3).to_i)
    flag = 0

    #解析沪深300数据
    File.open(hushen300_path, "r") do |file|
      file.each_line.with_index do |line, index|
        #容错处理
        break if line.blank?

        array = line.chomp.split(" ")
        initial_value = array[1].to_f if array[0].to_time == begin_date
        
        if array[0].to_time >= begin_date && flag == 0 .. array[0].to_time >= end_date
          time = array[0].to_time.to_i.to_s + "000"
          time = time.to_i
          data = array[1].to_f / initial_value
          item = [time, data]
          hushen_data << item
          flag = 1 if array[0].to_time >= end_date
        end
      end
    end

    hs_data = []

    other_data.each do |a|
      hushen_data.each do |b|
        if b[0] == a[0]
          hs_data << b
          break
        end
      end
    end

    [other_data,hs_data]
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:cell, :username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:cell, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :abstract) }
  end
end
