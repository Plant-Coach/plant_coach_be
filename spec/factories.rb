# require 'rails_helper'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }
    email { 'joel@plantcoach.com' }
    zip_code { '90210' }
    password { Faker::Alphanumeric.alpha(number: 10) }
    fall_frost_date { Faker::Date.forward(days: 50) }
    spring_frost_date { Faker::Date.forward(days: 120) }
  end

  factory :garden_plant do
    transient do
      user { build(:user) }
    end

    recommended_transplant_date { Faker::Date.forward(days: 50) }
    planting_status { 'not_started' }
    recommended_seed_sewing_date { Faker::Date.forward(days: 20) }
    seedling_days_to_transplant { Faker::Number.between(from: 7, to: 75) }
    plant_start_method { :indirect_sew }
    direct_seed_recommended { Faker::Boolean.boolean(true_ratio: 0.5) }
  end
end
