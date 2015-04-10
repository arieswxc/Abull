#!/usr/bin/env ruby

require "open-uri"
require "uri"

@stock_name = ARGV[0]

if @stock_name == '-h'
  puts "第一个参数是股票的代码"
  puts "第二个参数是起始日期 格式为 2014-01-02 代表 2014-01-02"
  puts "第三个参数是起始日期 格式同上"
  puts "事例 ./get_stock_price 000000 2011-01-02 2011-02-01"
  exit
elsif ARGV.size != 3
  puts "输入参数错误 请输入 -h 查看帮助"
  exit
end

@begin_date = Date.parse(ARGV[1])
@end_date = Date.parse(ARGV[2])

#浦发 60000

# @address="http://ichart.yahoo.com/table.csv?s=#{@stock_name}.ss&a=#{@begin_date.mon - 1}&b=#{@begin_date.day}&c=#{@begin_date.year}&d=#{@end_date.mon - 1}&e=#{@end_date.day}&f=#{@end_date.year}&g=d"
@address="http://table.finance.yahoo.com/table.csv?s=#{@stock_name}.ss&a=#{@begin_date.mon - 1}&b=#{@begin_date.day}&c=#{@begin_date.year}&d=#{@end_date.mon - 1}&e=#{@end_date.day}&f=#{@end_date.year}&g=d"

open(@address) do |f|
  f.each_line.with_index do |line,index|
    arr=line.split(",")
    arr.each do |data|
      print "#{data}      "
    end
  end
end
