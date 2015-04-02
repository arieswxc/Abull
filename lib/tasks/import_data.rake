namespace :data do
  task :greet => :environment do  
    puts "Hello World!"  
  end 

  desc "update day's homs_account"
  task update_homs: :environment do
  user = User.find(1)
  current_path = user.line_csv.current_path
  File.open(current_path, "r") do |file|
    file = file.read
    # file = file.encode("utf-8", "gbk")
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
end