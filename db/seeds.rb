# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AdminUser.create!(
  cell: '15000035210', 
  password: 'password123', 
  password_confirmation: 'password123', 
  role: "admin", 
  email: "moerjie@molstr.com")

CsvFile.create!(
  title: '每日账单数据')

CsvFile.create!(
  title: '利率表')
