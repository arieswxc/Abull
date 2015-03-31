# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AdminUser.create!(
  cell: '12345678901', 
  password: 'password123', 
  password_confirmation: 'password123', 
  role: "customer_service", 
  email: "foobar1@example.com")
user = User.create!(
  cell: '12345678901', 
  password: 'password123', 
  password_confirmation: 'password123', 
  email: "foobar2@example.com")
admin = User.create!(
  email: 'moerjie@molstr.com',
  password: 'mol6868068',
  cell: '15000035210',
  username: '摩尔街',
  real_name: '摩尔街',
  birthday: '2015-03-06',
  education: '博士')
Account.create!(user_id: admin.id, balance: 0)
Account.create!(user_id: user.id, balance: 0)