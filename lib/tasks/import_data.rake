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
        homs_title = arr[4]
        amount = arr[12]
        homs_account = HomsAccount.find_by(title: homs_title.to_s) ? HomsAccount.find_by(title: homs_title.to_s) : HomsAccount.find_by(title: homs_title.to_i)
        puts "homs_account #{homs_account}   homs_title #{homs_title}"
        homs_account.homs_properties.create(amount: amount, date: Time.now.to_date) if homs_account
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
  
end