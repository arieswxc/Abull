File.open("hs300_data.csv", "r") do |file|
  File.open("hs300_data_v.csv", "a+") do |f|
    file.each_line do |line|
        f << "#{line}      "
    end            
  end
end