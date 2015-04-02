 File.open("./账单.csv", "r") do |file|
    file = file.read
    file = file.encode("utf-8", "gbk")
    # puts file
      file.each_line.with_index do |line, index|
      #   lines = line.encode("utf-8", "gbk")
        arr = line.split(",")
        homs_title = arr[4]
        amount = arr[12]
        homs_account = HomsAccount.find_by(title: homs_title)
        homs_account.homs_properties.create(amount: amount, date: Time.now.to_date) if homs_account
      end
    end