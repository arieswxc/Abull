 File.open("./列表.csv", "r") do |file|
    file = file.read
    # file = file.encode("utf-8", "gbk") 
    # puts file
      array_x = []
      array_y = []
      file.each_line do |line|
        pos_x, pos_y = line.chomp.split(",")
        array_x = array_x << pos_x
        array_y = array_y << pos_y
      end
    puts array_x.to_s
    end

    # interval = (array_x.length / 10).to_i
    # array_x.reverse!
    # 0.upto(array_x.length) do |index|
    #   array_x[index] = "" if index % interval != 0
    # end
    
    # array_x.reverse!
    # [array_x, array_y]



