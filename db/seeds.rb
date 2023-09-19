# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
GardenPlant.destroy_all
Plant.destroy_all
PlantGuide.destroy_all
User.destroy_all

User.create(
  name: 'Joel Grant',
  email: 'joel@plantcoach.com',
  zip_code: '80121',
  password: '12345',
  password_confirmation: '12345'
)
user = User.create(
  name: 'Joel Test',
  email: 'joelaccount@plantcoach.com',
  zip_code: '80121',
  password: '12345',
  password_confirmation: '12345'
)
user2 = User.create(
  name: 'Joel Grant2',
  email: 'joel2@plantcoach.com',
  zip_code: '80121',
  password: '12345',
  password_confirmation: '12345'
)


# tomato = user.plant_guides.create(
#   plant_type: "Tomato",
#   seedling_days_to_transplant: 49,
#   direct_seed_recommended: false,
#   days_to_maturity: 45,
#   days_relative_to_frost_date: 14,
#   harvest_period: "season_long"
# )

# pepper = user.plant_guides.create(
#   plant_type: "Pepper",
#   seedling_days_to_transplant: 49,
#   direct_seed_recommended: false,
#   days_to_maturity: 45,
#   days_relative_to_frost_date: 14,
#   harvest_period: "season_long"
# )
# eggplant = user.plant_guides.create(
#   plant_type: "Eggplant",
#   seedling_days_to_transplant: 49,
#   direct_seed_recommended: false,
#   days_to_maturity: 45,
#   days_relative_to_frost_date: 14,
#   harvest_period: "season_long"
# )
# romaine = user.plant_guides.create(
#   plant_type: "Romaine Lettuce",
#   seedling_days_to_transplant: 0,
#   direct_seed_recommended: true,
#   days_to_maturity: 45,
#   days_relative_to_frost_date: 14,
#   harvest_period: "one_time"
# )
# green_bean = user.plant_guides.create(
#   plant_type: "Green Bean",
#   seedling_days_to_transplant: 0,
#   direct_seed_recommended: true,
#   days_to_maturity: 45,
#   days_relative_to_frost_date: 14,
#   harvest_period: "season_long"
# )
# radish = user.plant_guides.create(
#   plant_type: "Radish",
#   seedling_days_to_transplant: 0,
#   direct_seed_recommended: true,
#   days_to_maturity: 45,
#   days_relative_to_frost_date: 14,
#   harvest_period: "one_time"
# )
# basil_guide = user.plant_guides.create(
#   plant_type: "Basil",
#   seedling_days_to_transplant: 0,
#   direct_seed_recommended: true,
#   days_to_maturity: 30,
#   days_relative_to_frost_date: 0,
#   harvest_period: "three_week"
# )

# user2.plant_guides.create(
#   plant_type: "Tomato",
#   seedling_days_to_transplant: 49,
#   direct_seed_recommended: false,
#   days_to_maturity: 45,
#   days_relative_to_frost_date: 14,
#   harvest_period: "season_long"
# )
# user2.plant_guides.create(
#   plant_type: "Pepper",
#   seedling_days_to_transplant: 49,
#   direct_seed_recommended: false,
#   days_to_maturity: 45,
#   days_relative_to_frost_date: 14,
#   harvest_period: "season_long"
# )
# user2.plant_guides.create(
#   plant_type: "Eggplant",
#   seedling_days_to_transplant: 49,
#   direct_seed_recommended: false,
#   days_to_maturity: 45,
#   days_relative_to_frost_date: 14,
#   harvest_period: "season_long"
# )
# user2.plant_guides.create(
#   plant_type: "Romaine Lettuce",
#   seedling_days_to_transplant: 0,
#   direct_seed_recommended: true,
#   days_to_maturity: 45,
#   days_relative_to_frost_date: 14,
#   harvest_period: "one_time"
# )
# user2.plant_guides.create(
#   plant_type: "Green Bean",
#   seedling_days_to_transplant: 0,
#   direct_seed_recommended: true,
#   days_to_maturity: 45,
#   days_relative_to_frost_date: 14,
#   harvest_period: "season_long"
# )
# user2.plant_guides.create(
#   plant_type: "Radish",
#   seedling_days_to_transplant: 0,
#   direct_seed_recommended: true,
#   days_to_maturity: 45,
#   days_relative_to_frost_date: 14,
#   harvest_period: "one_time"
# )
# user2.plant_guides.create(
#   plant_type: "Basil",
#   seedling_days_to_transplant: 0,
#   direct_seed_recommended: true,
#   days_to_maturity: 30,
#   days_relative_to_frost_date: 0,
#   harvest_period: "three_week"
# )


plant1 = user.plants.create(name: "Sungold", plant_type: "Tomato", days_relative_to_frost_date: 14, days_to_maturity: 60, hybrid_status: 1)
plant2 = user.plants.create(name: "Rosa Bianca", plant_type: "Eggplant", days_relative_to_frost_date: 14, days_to_maturity: 70, hybrid_status: 1)
plant3 = user.plants.create(name: "Jalafuego", plant_type: "Pepper", days_relative_to_frost_date: 14, days_to_maturity: 65, hybrid_status: 1)
plant4 = user.plants.create(name: "French Breakfast", plant_type: "Radish", days_relative_to_frost_date: 28, days_to_maturity: 21, hybrid_status: 1)
plant5 = user.plants.create(name: "Provider", plant_type: "Green Bean", days_relative_to_frost_date: 7, days_to_maturity: 45, hybrid_status: 1)
plant6 = user.plants.create(name: "San Marzano II", plant_type: "Tomato", days_relative_to_frost_date: 14, days_to_maturity: 68, hybrid_status: 1)
# plant7 = user.plants.create(name: "Toma Verde", plant_type: "Tomatillo", days_relative_to_frost_date: 14, days_to_maturity: 68, hybrid_status: 1)
plant8 = user.plants.create(name: "Genovese", plant_type: "Basil", days_relative_to_frost_date: 0, days_to_maturity: 42, hybrid_status: 1)
# plant9 = user.plants.create(name: "Corinto", plant_type: "Cucumber", days_relative_to_frost_date: 14, days_to_maturity: 49, hybrid_status: 1)
# plant10 = user.plants.create(name: "Champion", plant_type: "Pumpkin", days_relative_to_frost_date: 21, days_to_maturity: 75, hybrid_status: 1)

user2_plant1 = user2.plants.create(name: "Sungold", plant_type: "Tomato", days_relative_to_frost_date: 14, days_to_maturity: 60, hybrid_status: 1)
user2_plant2 = user2.plants.create(name: "Rosa Bianca", plant_type: "Eggplant", days_relative_to_frost_date: 14, days_to_maturity: 70, hybrid_status: 1)
user2_plant3 = user2.plants.create(name: "Jalafuego", plant_type: "Pepper", days_relative_to_frost_date: 14, days_to_maturity: 65, hybrid_status: 1)
user2_plant4 = user2.plants.create(name: "French Breakfast", plant_type: "Radish", days_relative_to_frost_date: 28, days_to_maturity: 21, hybrid_status: 1)
user2_plant5 = user2.plants.create(name: "Provider", plant_type: "Green Bean", days_relative_to_frost_date: 7, days_to_maturity: 45, hybrid_status: 1)
user2_plant6 = user2.plants.create(name: "San Marzano II", plant_type: "Tomato", days_relative_to_frost_date: 14, days_to_maturity: 68, hybrid_status: 1)

plant1.garden_plants.create(planting_status: "not_started", plant_start_method: :indirect_sew, actual_seed_sewing_date: Date.today)
plant2.garden_plants.create(planting_status: "not_started", plant_start_method: :indirect_sew, actual_seed_sewing_date: Date.today)
plant3.garden_plants.create(planting_status: "not_started", plant_start_method: :indirect_sew, actual_seed_sewing_date: Date.today)
plant4.garden_plants.create(planting_status: "not_started", plant_start_method: :direct_sew, actual_seed_sewing_date: Date.today)
plant5.garden_plants.create(planting_status: "not_started", plant_start_method: :direct_sew, actual_seed_sewing_date: Date.today)

user2_plant1.garden_plants.create(planting_status: "not_started", plant_start_method: :indirect_sew, actual_seed_sewing_date: Date.today)
user2_plant2.garden_plants.create(planting_status: "not_started", plant_start_method: :indirect_sew, actual_seed_sewing_date: Date.today)
user2_plant3.garden_plants.create(planting_status: "not_started", plant_start_method: :indirect_sew, actual_seed_sewing_date: Date.today)
user2_plant4.garden_plants.create(planting_status: "not_started", plant_start_method: :direct_sew, actual_seed_sewing_date: Date.today)
user2_plant5.garden_plants.create(planting_status: "not_started", plant_start_method: :direct_sew, actual_seed_sewing_date: Date.today)
user2_plant6.garden_plants.create(planting_status: "not_started", plant_start_method: :indirect_sew)
