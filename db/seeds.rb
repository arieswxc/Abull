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
  role: "admin", 
  email: "foobar1@example.com")
admin = User.create!(
  email: 'moerjie@molstr.com',
  password: 'mol6868068',
  cell: '15000035210',
  username: '摩尔街',
  real_name: '摩尔街',
  birthday: '2015-03-06',
  education: '博士')
Account.create!(user_id: admin.id, balance: 0)

user1 = User.create!(
  username: 'zjs01',
  cell: '00000000001',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  level: 'investor_applied'
  )
Account.create!(user_id: user1.id, balance: 0)

user2 = User.create!(
  username: 'zjs02',
  cell: '00000000002',
  password: 'a00000000',
  password_confirmation: 'a00000000'
  )
Account.create!(user_id: user2.id, balance: 0)

user3 = User.create!(
  username: 'zjs03',
  cell: '00000000003',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  level: 'investor_applied'
  )
Account.create!(user_id: user3.id, balance: 0)
user4 = User.create!(
  username: 'zjs04',
  cell: '00000000004',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  level: 'investor_applied'
  )
Account.create!(user_id: user4.id, balance: 0)
user5 = User.create!(
  username: 'zjs05',
  cell: '00000000005',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  level: 'investor_applied'
  )
Account.create!(user_id: user5.id, balance: 0)

user6 = User.create!(
  username: 'zjs06',
  cell: '00000000006',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  level: 'investor_applied'
  )
Account.create!(user_id: user6.id, balance: 0)

user7 = User.create!(
  username: 'zjs07',
  cell: '00000000007',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  level: 'investor_applied'
  )
Account.create!(user_id: user7.id, balance: 0)
user8 = User.create!(
  username: 'zjs08',
  cell: '00000000008',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  level: 'investor_applied'
  )
Account.create!(user_id: user8.id, balance: 0)