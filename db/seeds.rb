# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Plant.destroy_all

user = User.create(
  name: 'Joel Grant',
  email: 'joel@plantcoach.com',
  zip_code: '80121',
  password: '12345',
  password_confirmation: '12345'
)

plant1 = Plant.create(name: "Sungold", plant_type: "Tomato", days_relative_to_frost_date: 14, days_to_maturity: 60, hybrid_status: 1)
plant2 = Plant.create(name: "Rosa Bianca", plant_type: "Eggplant", days_relative_to_frost_date: 14, days_to_maturity: 70, hybrid_status: 1)
plant3 = Plant.create(name: "Jalafuego", plant_type: "Pepper", days_relative_to_frost_date: 14, days_to_maturity: 65, hybrid_status: 1)
plant4 = Plant.create(name: "French Breakfast", plant_type: "Radish", days_relative_to_frost_date: 28, days_to_maturity: 21, hybrid_status: 1)
plant5 = Plant.create(name: "Provider", plant_type: "Pole Bean", days_relative_to_frost_date: 7, days_to_maturity: 45, hybrid_status: 1)
plant6 = Plant.create(name: "San Marzano II", plant_type: "Tomato", days_relative_to_frost_date: 14, days_to_maturity: 68, hybrid_status: 1)
plant7 = Plant.create(name: "Toma Verde", plant_type: "Tomatillo", days_relative_to_frost_date: 14, days_to_maturity: 68, hybrid_status: 1)
plant8 = Plant.create(name: "Genovese", plant_type: "Basil", days_relative_to_frost_date: 0, days_to_maturity: 42, hybrid_status: 1)
plant9 = Plant.create(name: "Corinto", plant_type: "Cucumber", days_relative_to_frost_date: 14, days_to_maturity: 49, hybrid_status: 1)
plant10 = Plant.create(name: "Champion", plant_type: "Pumpkin", days_relative_to_frost_date: 21, days_to_maturity: 75, hybrid_status: 1)


UserPlant.create(user_id: user.id, plant_id: plant1.id)
UserPlant.create(user_id: user.id, plant_id: plant2.id)
UserPlant.create(user_id: user.id, plant_id: plant3.id)
UserPlant.create(user_id: user.id, plant_id: plant4.id)
UserPlant.create(user_id: user.id, plant_id: plant5.id)
