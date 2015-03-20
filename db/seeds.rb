# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AdminUser.create!(cell: '12345678901', password: 'password123', password_confirmation: 'password123', role: "customer_service")
User.create!(email: '12345678901', password: 'password123', password_confirmation: 'password123')