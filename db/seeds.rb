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
plant5 = user.plants.create(name: "Provider", plant_type: "Pole Bean", days_relative_to_frost_date: 7, days_to_maturity: 45, hybrid_status: 1)
plant6 = user.plants.create(name: "San Marzano II", plant_type: "Tomato", days_relative_to_frost_date: 14, days_to_maturity: 68, hybrid_status: 1)
plant7 = user.plants.create(name: "Toma Verde", plant_type: "Tomatillo", days_relative_to_frost_date: 14, days_to_maturity: 68, hybrid_status: 1)
plant8 = user.plants.create(name: "Genovese", plant_type: "Basil", days_relative_to_frost_date: 0, days_to_maturity: 42, hybrid_status: 1)
plant9 = user.plants.create(name: "Corinto", plant_type: "Cucumber", days_relative_to_frost_date: 14, days_to_maturity: 49, hybrid_status: 1)
plant10 = user.plants.create(name: "Champion", plant_type: "Pumpkin", days_relative_to_frost_date: 21, days_to_maturity: 75, hybrid_status: 1)

user.garden_plants.create(name: "Sungold", plant_type: "Tomato", days_relative_to_frost_date: 14, days_to_maturity: 60, hybrid_status: 1)
user.garden_plants.create(name: "Rosa Bianca", plant_type: "Eggplant", days_relative_to_frost_date: 14, days_to_maturity: 70, hybrid_status: 1)
user.garden_plants.create(name: "Jalafuego", plant_type: "Pepper", days_relative_to_frost_date: 14, days_to_maturity: 65, hybrid_status: 1)
user.garden_plants.create(name: "French Breakfast", plant_type: "Radish", days_relative_to_frost_date: 28, days_to_maturity: 21, hybrid_status: 1)
user.garden_plants.create(name: "Provider", plant_type: "Pole Bean", days_relative_to_frost_date: 7, days_to_maturity: 45, hybrid_status: 1)

user2.garden_plants.create(name: "Sungold", plant_type: "Tomato", days_relative_to_frost_date: 14, days_to_maturity: 60, hybrid_status: 1)
user2.garden_plants.create(name: "Rosa Bianca", plant_type: "Eggplant", days_relative_to_frost_date: 14, days_to_maturity: 70, hybrid_status: 1)

basil = PlantingGuide.create(
  plant_type: "Basil",
  description: "<description_placeholder>"
)
broccoli  = PlantingGuide.create(
  plant_type: "broccoli",
  description: "<description_placeholder>"
)
cabbage  = PlantingGuide.create(
  plant_type: "cabbage",
  description: "<description_placeholder>"
)
cauliflower  = PlantingGuide.create(
  plant_type: "cauliflower",
  description: "<description_placeholder>"
)
celery  = PlantingGuide.create(
  plant_type: "celery",
  description: "<description_placeholder>"
)
cucumber  = PlantingGuide.create(
  plant_type: "cucumber",
  description: "<description_placeholder>"
)
eggplant  = PlantingGuide.create(
  plant_type: "eggplant",
  description: "<description_placeholder>"
)
kale  = PlantingGuide.create(
  plant_type: "kale",
  description: "<description_placeholder>"
)
leeks  = PlantingGuide.create(
  plant_type: "leeks",
  description: "<description_placeholder>"
)
lettuce  = PlantingGuide.create(
  plant_type: "lettuce",
  description: "<description_placeholder>"
)
melons  = PlantingGuide.create(
  plant_type: "melons",
  description: "<description_placeholder>"
)
onions  = PlantingGuide.create(
  plant_type: "onions",
  description: "<description_placeholder>"
)
parsley  = PlantingGuide.create(
  plant_type: "parsley",
  description: "<description_placeholder>"
)
peas  = PlantingGuide.create(
  plant_type: "peas",
  description: "<description_placeholder>"
)
peppers  = PlantingGuide.create(
  plant_type: "peppers",
  description: "<description_placeholder>"
)
pumpkins  = PlantingGuide.create(
  plant_type: "pumpkins",
  description: "<description_placeholder>"
)
spinach = PlantingGuide.create(
  plant_type: "spinach",
  description: "<description_placeholder>"
)
squash = PlantingGuide.create(
  plant_type: "squash",
  description: "<description_placeholder>"
)
swiss_chard = PlantingGuide.create(
  plant_type: "swiss_chard",
  description: "<description_placeholder>"
)
tomatoes = PlantingGuide.create(
  plant_type: "tomatoes",
  description: "<description_placeholder>"
)
watermelon = PlantingGuide.create(
  plant_type: "watermelon",
  description: "<description_placeholder>"
)

tomato_seed = SeedDefaultData.create(
  plant_type: "Tomato",
  days_to_maturity: 55,
  seedling_days_to_transplant: 49,
  days_relative_to_frost_date: 14,
  direct_seed_recommendation: :no
)
pepper_seed = SeedDefaultData.create(
  plant_type: "Pepper",
  days_to_maturity: 64,
  seedling_days_to_transplant: 49,
  days_relative_to_frost_date: 14,
  direct_seed_recommendation: :no
)
eggplant_seed = SeedDefaultData.create(
  plant_type: "Eggplant",
  days_to_maturity: 68,
  seedling_days_to_transplant: 49,
  days_relative_to_frost_date: 14,
  direct_seed_recommendation: :no
)
romaine_seed = SeedDefaultData.create(
  plant_type: "Romaine Lettuce",
  days_to_maturity: 35,
  seedling_days_to_transplant: 14,
  days_relative_to_frost_date: -28,
  direct_seed_recommendation: :yes
)
green_bean_seed = SeedDefaultData.create(
  plant_type: "Green Bean",
  days_to_maturity: 52,
  seedling_days_to_transplant: 14,
  days_relative_to_frost_date: 0,
  direct_seed_recommendation: :yes
)
