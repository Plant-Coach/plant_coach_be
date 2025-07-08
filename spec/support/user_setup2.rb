RSpec.shared_context 'user_setup2' do
  before :each do
    ActiveRecord::Base.skip_callbacks = false
    body = {
      name: 'Joel Grant',
      email: 'joel@plantcoach.com',
      zip_code: '80121',
      password: '12345',
      password_confirmation: '12345'
    }
    post '/api/v1/users', params: body

    @user_response = JSON.parse(response.body, symbolize_names: true)
    @user = User.find_by_id(@user_response[:user][:data][:id])

    @user.plant_guides.create(
      plant_type: 'Something else',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: 'one_time'
    )

    @tomato_guide = @user.plant_guides.create(
      plant_type: 'Tomato',
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: 'season_long'
    )

    @user.plant_guides.create(
      plant_type: 'Pepper',
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: 'season_long'
    )
    @user.plant_guides.create(
      plant_type: 'Eggplant',
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: 'season_long'
    )
    @user.plant_guides.create(
      plant_type: 'Romaine Lettuce',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: 'one_time'
    )
    @user.plant_guides.create(
      plant_type: 'Green Bean',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: 'season_long'
    )
    @user.plant_guides.create(
      plant_type: 'Radish',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 45,
      days_relative_to_frost_date: 14,
      harvest_period: 'one_time'
    )
    @user.plant_guides.create(
      plant_type: 'Carrot',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 60,
      days_relative_to_frost_date: -30,
      harvest_period: 'one_week'
    )
    @user.plant_guides.create(
      plant_type: 'Sprouting Broccoli',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 45,
      days_relative_to_frost_date: -30,
      harvest_period: 'four_week'
    )
    @user.plant_guides.create(
      plant_type: 'Basil',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 30,
      days_relative_to_frost_date: 0,
      harvest_period: 'three_week'
    )
    @user.plant_guides.create(
      plant_type: 'Cilantro',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true,
      days_to_maturity: 30,
      days_relative_to_frost_date: 0,
      harvest_period: 'two_week'
    )
  end

  let(:plant1_object) do
    @user.plants.create!(
      name: 'Sungold',
      plant_type: 'Tomato',
      days_relative_to_frost_date: 14,
      days_to_maturity: 60,
      hybrid_status: 1
    )
  end
  let(:plant2_object) do
    @user.plants.create!(
      name: 'Jalafuego',
      plant_type: 'Pepper',
      days_relative_to_frost_date: 14,
      days_to_maturity: 65,
      hybrid_status: 1
    )
  end
  let(:plant3_object) do
    @user.plants.create!(
      name: 'Rosa Bianca',
      plant_type: 'Eggplant',
      days_relative_to_frost_date: 14,
      days_to_maturity: 70,
      hybrid_status: 1
    )
  end
  let(:plant4_object) do
    @user.plants.create!(
      name: 'Coastal Star',
      plant_type: 'Romaine Lettuce',
      days_relative_to_frost_date: -45,
      days_to_maturity: 30,
      hybrid_status: 1
    )
  end
end
