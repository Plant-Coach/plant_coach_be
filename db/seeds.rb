# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
  name: 'Joel Grant',
  email: 'joel@plantcoach.com',
  zip_code: '80121',
  password: '12345',
  password_confirmation: '12345'
)
