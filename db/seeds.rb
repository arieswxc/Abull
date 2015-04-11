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
  cell: '17601572001',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  real_name: '张在',
  id_card_number: '330303030303030303',
  abstract: '嘎的打击手段大事啊呃我打发打发啊多少发多少访问打发打发打发',
  level: 'investor',
  birthday: '1990-01-01',
  gender: 'male',
  education: '本科',
  address: '上海中山',
  job: '程序员'
  )

User.create!(
  username: 'zjs02',
  cell: '17601572002',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  real_name: '张在一',
  id_card_number: '330303030303030303',
  abstract: '嘎的打击手段大事啊呃我打发打发啊多少发多少访问打发打发打发',
  level: 'investor',
  birthday: '1990-01-01',
  gender: 'male',
  education: '本科',
  address: '上海中山',
  job: '程序员'
  )

User.create!(
  username: 'zjs03',
  cell: '17601572003',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  real_name: '张在三',
  id_card_number: '330303030303030303',
  abstract: '嘎的打击手段大事啊呃我打发打发啊多少发多少访问打发打发打发',
  level: 'investor',
  birthday: '1990-01-01',
  gender: 'male',
  education: '本科',
  address: '上海中山',
  job: '程序员'
  )

User.create!(
  username: 'zjs04',
  cell: '17601572004',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  real_name: '张在四',
  id_card_number: '330303030303030303',
  abstract: '嘎的打击手段大事啊呃我打发打发啊多少发多少访问打发打发打发',
  level: 'investor',
  birthday: '1990-01-01',
  gender: 'male',
  education: '本科',
  address: '上海中山',
  job: '程序员'
  )

User.create!(
  username: 'zjs05',
  cell: '17601572005',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  real_name: '张在五',
  id_card_number: '330303030303030303',
  abstract: '嘎的打击手段大事啊呃我打发打发啊多少发多少访问打发打发打发',
  level: 'investor',
  birthday: '1990-01-01',
  gender: 'male',
  education: '本科',
  address: '上海中山',
  job: '程序员'
  )

User.create!(
  username: 'zjs06',
  cell: '17601572006',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  real_name: '张在六',
  id_card_number: '330303030303030303',
  abstract: '嘎的打击手段大事啊呃我打发打发啊多少发多少访问打发打发打发',
  level: 'trader',
  birthday: '1990-01-01',
  gender: 'male',
  education: '本科',
  address: '上海中山',
  job: '程序员'
  )

User.create!(
  username: 'zjs07',
  cell: '17601572007',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  real_name: '张在七',
  id_card_number: '330303030303030303',
  abstract: '嘎的打击手段大事啊呃我打发打发啊多少发多少访问打发打发打发',
  level: 'trader',
  birthday: '1990-01-01',
  gender: 'male',
  education: '本科',
  address: '上海中山',
  job: '程序员'
  )

User.create!(
  username: 'zjs08',
  cell: '17601572008',
  password: 'a00000000',
  password_confirmation: 'a00000000',
  real_name: '张在八',
  id_card_number: '330303030303030303',
  abstract: '嘎的打击手段大事啊呃我打发打发啊多少发多少访问打发打发打发',
  level: 'trader',
  birthday: '1990-01-01',
  gender: 'male',
  education: '本科',
  address: '上海中山',
  job: '程序员'
  )