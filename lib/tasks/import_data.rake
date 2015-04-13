require "open-uri"
require "uri"
namespace :data do
  task :greet => :environment do  
    puts "Hello World!"  
  end 

  desc "update day's homs_account"
  task update_homs: :environment do
  csv_file = CsvFile.find_by(title: "每日账单数据")
  current_path = csv_file.file.current_path
  File.open(current_path, "r") do |file|
    file = file.read
    file = file.encode("utf-8", "gbk") if file.encoding.name == "GBK"
    # puts file
      file.each_line.with_index do |line, index|
        arr = line.split(",")
        date = arr[0].to_time
        homs_title = arr[1]
        amount = arr[2]
        homs_account = HomsAccount.find_by(title: homs_title.to_s) ? HomsAccount.find_by(title: homs_title.to_s) : HomsAccount.find_by(title: homs_title.to_i)
        puts "homs_account #{homs_account}   homs_title #{homs_title}"
        homs_account.homs_properties.create(amount: amount, date: date) if homs_account
      end
    end
  end

  desc "导入利率表"
  task import_interests: :environment do
    csv_file = CsvFile.find_by(title: "利率表")
    current_path = csv_file.file.current_path
    Interest.destroy_all
    File.open(current_path, "r") do |file|
      file = file.read
      file = file.encode("utf-8", "gbk")  if file.encoding.name == "GBK"
      file.each_line.with_index do |line, index|
        arr = line.split(",")
        leverage_time = arr[0]
        duration = arr[1]
        amount = arr[2]
        interest_rate = arr[3]
        managerment_fee = arr[4]
        interest = Interest.create(leverage_time: leverage_time, duration: duration, amount: amount, interest_rate: interest_rate, managerment_fee: managerment_fee, show: 'true') if !leverage_time.blank?
      end
    end
  end

  task get_hs300_data: :environment do    
    @end_date = Time.now.to_date.advance(days: -1)
    @begin_date = Time.now.to_date.advance(days: -1)
    @address="http://table.finance.yahoo.com/table.csv?s=000300.ss&a=#{@begin_date.mon - 1}&b=#{@begin_date.day}&c=#{@begin_date.year}&d=#{@end_date.mon - 1}&e=#{@end_date.day}&f=#{@end_date.year}&g=d"

    File.open("#{Rails.root}/lib/LibFile/hs300_data.csv", "a+") do |file|
      open(@address) do |f|
        f.each_line.with_index do |line,index|
          arr=line.split(",")
          arr.each do |data|
            file << "#{data}      " if index !=0 && !data.blank?
          end            
        end
      end
    end
    
  end
end