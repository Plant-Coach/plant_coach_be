RSpec.shared_context 'user_setup' do
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
    @raspberry_guide = @user.plant_guides.create(
      plant_type: 'Raspberry',
      seedling_days_to_transplant: 0,
      direct_seed_recommended: false,
      days_to_maturity: 100,
      days_relative_to_frost_date: 0,
      harvest_period: 'season_long'
    )
  end

  let(:plant1_object) do
    @user.plants.create!(
      plant_type: 'Tomato',
      name: 'Sungold',
      days_relative_to_frost_date: 14,
      days_to_maturity: 54,
      hybrid_status: 1,
      organic: false
    )
  end

  let(:plant2_object) do
    @user.plants.create!(
      plant_type: 'Pepper',
      name: 'Jalafuego',
      days_relative_to_frost_date: 14,
      days_to_maturity: 65,
      hybrid_status: 1,
      organic: false
    )
  end

  let(:plant3_object) do
    last_user.plants.create!(
      plant_type: 'Radish',
      name: 'French Breakfast',
      days_relative_to_frost_date: 30,
      days_to_maturity: 21,
      hybrid_status: :f1
    )
  end

  let(:user_response) { JSON.parse(response.body, symbolize_names: true) }
  let(:user) { User.find_by_id(user_response[:user][:data][:id]) }
  let(:last_user) { User.last }

  let(:plant1_params) do
    {
      plant_type: 'Tomato',
      name: 'Sungold',
      days_relative_to_frost_date: 14,
      days_to_maturity: 54,
      hybrid_status: :f1
    }
  end
  let(:plant2_params) do
    {
      plant_type: 'Pepper',
      name: 'Round of Hungary',
      days_relative_to_frost_date: 14,
      days_to_maturity: 60,
      hybrid_status: :f1
    }
  end
  let(:plant3_params) do
    {
      plant_type: 'Eggplant',
      name: 'Rosa Bianca',
      days_relative_to_frost_date: 14,
      days_to_maturity: 68,
      hybrid_status: :open_pollinated
    }
  end
  let(:plant4_params) do
    {
      plant_type: 'Romaine Lettuce',
      name: 'Costal Star',
      days_relative_to_frost_date: 30,
      days_to_maturity: 25,
      hybrid_status: :f1
    }
  end
  let(:plant5_params) do
    {
      plant_type: 'Green Bean',
      name: 'Provider',
      days_relative_to_frost_date: -7,
      days_to_maturity: 45,
      hybrid_status: :f1
    }
  end
  
end
