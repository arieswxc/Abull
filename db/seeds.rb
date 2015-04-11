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
admin = User.create!(
  email: 'moerjie@molstr.com',
  password: 'mol6868068',
  cell: '15000035210',
  username: '摩尔街',
  real_name: '摩尔街',
  birthday: '2015-03-06',
  education: '博士')
Account.create!(user_id: admin.id, balance: 0)

User.create!(
  username: 'zjs01',
  cell: '00000000001',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  level: 'investor_applied'
  )

User.create!(
  username: 'zjs02',
  cell: '00000000002',
  password: 'a00000000',
  password_confirmation: 'a00000000'
  )

User.create!(
  username: 'zjs03',
  cell: '00000000003',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  level: 'investor_applied'
  )

User.create!(
  username: 'zjs04',
  cell: '00000000004',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  level: 'investor_applied'
  )

User.create!(
  username: 'zjs05',
  cell: '00000000005',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  level: 'investor_applied'
  )

User.create!(
  username: 'zjs06',
  cell: '00000000006',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  level: 'investor_applied'
  )

User.create!(
  username: 'zjs07',
  cell: '00000000007',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  level: 'investor_applied'
  )

User.create!(
  username: 'zjs08',
  cell: '00000000008',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  level: 'investor_applied'
  )