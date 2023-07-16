# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
GardenPlant.destroy_all
Plant.destroy_all
User.destroy_all
SeedGuide.destroy_all
TransplantGuide.destroy_all
HarvestGuide.destroy_all

tomato_seed = SeedGuide.create(
  plant_type: "Tomato",
  seedling_days_to_transplant: 49,
  direct_seed_recommended: false,
  recommended_transplant_date: true,
  recommended_seed_start_date: true
)
pepper_seed = SeedGuide.create(
  plant_type: "Pepper",
  seedling_days_to_transplant: 49,
  direct_seed_recommended: false,
  recommended_transplant_date: true,
  recommended_seed_start_date: true
)
eggplant_seed = SeedGuide.create(
  plant_type: "Eggplant",
  seedling_days_to_transplant: 49,
  direct_seed_recommended: false,
  recommended_transplant_date: true,
  recommended_seed_start_date: true
)
romaine_seed = SeedGuide.create(
  plant_type: "Romaine Lettuce",
  seedling_days_to_transplant: 14,
  direct_seed_recommended: true,
  recommended_transplant_date: true,
  recommended_seed_start_date: true
)
green_bean_seed = SeedGuide.create(
  plant_type: "Green Bean",
  seedling_days_to_transplant: 0,
  direct_seed_recommended: true,
  recommended_transplant_date: true,
  recommended_seed_start_date: true
)
radish_seed = SeedGuide.create(
  plant_type: "Radish",
  seedling_days_to_transplant: 0,
  direct_seed_recommended: true,
  recommended_transplant_date: true,
  recommended_seed_start_date: true
)
romaine_seed = SeedGuide.create(
      plant_type: "Romaine Lettuce",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      recommended_transplant_date: true,
      recommended_seed_start_date: true
    )

tomato_transplant = TransplantGuide.create(
  plant_type: "Tomato",
  days_to_maturity: 45,
  days_relative_to_frost_date: 14
)
pepper_transplant = TransplantGuide.create(
  plant_type: "Pepper",
  days_to_maturity: 45,
  days_relative_to_frost_date: 14
)
eggplant_transplant = TransplantGuide.create(
  plant_type: "Eggplant",
  days_to_maturity: 45,
  days_relative_to_frost_date: 14
)
romaine_transplant = TransplantGuide.create(
  plant_type: "Romaine Lettuce",
  days_to_maturity: 45,
  days_relative_to_frost_date: 14
)
green_bean_transplant =TransplantGuide.create(
  plant_type: "Green Bean",
  days_to_maturity: 45,
  days_relative_to_frost_date: 14
)
radish_transplant = TransplantGuide.create(
  plant_type: "Radish",
  days_to_maturity: 45,
  days_relative_to_frost_date: 14
)
romaine_transplant = TransplantGuide.create(
  plant_type: "Romaine Lettuce",
  days_to_maturity: 45,
  days_relative_to_frost_date: 14
)

tomato_harvest = HarvestGuide.create(
  plant_type: "Tomato",
  harvest_period: "season_long"
)
pepper_harvest = HarvestGuide.create(
  plant_type: "Pepper",
  harvest_period: "season_long"
)
eggplant_harvest = HarvestGuide.create(
  plant_type: "Eggplant",
  harvest_period: "season_long"
)
romaine_harvest = HarvestGuide.create(
  plant_type: "Romaine Lettuce",
  harvest_period: "one_time"
)
green_bean_harvest = HarvestGuide.create(
  plant_type: "Green Bean",
  harvest_period: "season_long"
)
radish_harvest = HarvestGuide.create(
  plant_type: "Radish",
  harvest_period: "one_week"
)
basil_harvest = HarvestGuide.create(
  plant_type: "Basil",
  harvest_period: "three_week"
)
broccoli_harvest = HarvestGuide.create(
  plant_type: "Sprouting Broccoli",
  harvest_period: "four_week"
)
cilantro_harvest = HarvestGuide.create(
  plant_type: "Cilantro",
  harvest_period: "two_week"
)


user = User.create(
  name: 'Joel Grant',
  email: 'joel@plantcoach.com',
  zip_code: '80121',
  password: '12345',
  password_confirmation: '12345'
)
user2 = User.create(
  name: 'Joao Athonille',
  email: 'joao@athonille.com',
  zip_code: '80112',
  password: '12345',
  password_confirmation: '12345'
)

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

plant1.garden_plants.create(name: "Sungold", plant_type: "Tomato", days_relative_to_frost_date: 14, days_to_maturity: 60, hybrid_status: 1, planting_status: "not_started", start_from_seed: true)
plant2.garden_plants.create(name: "Rosa Bianca", plant_type: "Eggplant", days_relative_to_frost_date: 14, days_to_maturity: 70, hybrid_status: 1, planting_status: "not_started", start_from_seed: true)
plant3.garden_plants.create(name: "Jalafuego", plant_type: "Pepper", days_relative_to_frost_date: 14, days_to_maturity: 65, hybrid_status: 1, planting_status: "not_started", start_from_seed: true)
plant4.garden_plants.create(name: "French Breakfast", plant_type: "Radish", days_relative_to_frost_date: 28, days_to_maturity: 21, hybrid_status: 1, planting_status: "not_started", start_from_seed: true)
plant5.garden_plants.create(name: "Provider", plant_type: "Green Bean", days_relative_to_frost_date: 7, days_to_maturity: 45, hybrid_status: 1, planting_status: "not_started", start_from_seed: true)

user2_plant1.garden_plants.create(name: "Sungold", plant_type: "Tomato", days_relative_to_frost_date: 14, days_to_maturity: 60, hybrid_status: 1, planting_status: "not_started", start_from_seed: true)
user2_plant2.garden_plants.create(name: "Rosa Bianca", plant_type: "Eggplant", days_relative_to_frost_date: 14, days_to_maturity: 70, hybrid_status: 1, planting_status: "not_started", start_from_seed: true)
