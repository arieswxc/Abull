# File.open("hs300_data.csv", "r") do |file|
#   File.open("hs300_data_v.csv", "a+") do |f|

#     file.each_line do |line|
#         f << "#{line}      "
#     end            
#   end
# end
arr = []
File.open("hs300_data.csv", "r") do |file|
  file.each_line do |l|
    arr << l
  end
end
arr.reverse!
arr.each do |a|
  File.open("hs300_data_v.csv", "a+") do |f|
    f << a
  end
end
