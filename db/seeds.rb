# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: "전지원", email: "jwurbane97@gmail.com", password: "urbane97#", level: 2)
User.create(name: "전지원", email: "jwurbane97@naver.com", password: "urbane97#", level: 2)