# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

SiteSetting.create(key: 'question_up_score', value: 10)
SiteSetting.create(key: 'question_down_score', value: -5)
StatusCode.create(name: 'opened')
StatusCode.create(name: 'accepted')
StatusCode.create(name: 'closed')
StatusCode.create(name: 'deleted')
