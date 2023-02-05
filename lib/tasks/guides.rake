require 'csv'

namespace :guides do
  desc 'Create Plant Guides Objects'
  task :create_plant_guides =>  :environment do

    SeedGuide.destroy_all
    TransplantGuide.destroy_all
    HarvestGuide.destroy_all
    PlantCoachGuide.destroy_all

    CSV.foreach('lib/seed_guides.csv', :headers => true) do |row|
      SeedGuide.create(row.to_hash)
    end

    CSV.foreach('lib/transplant_guides.csv', :headers => true) do |row|
      TransplantGuide.create(row.to_hash)
    end

    CSV.foreach('lib/harvest_guides.csv', :headers => true) do |row|
      HarvestGuide.create(row.to_hash)
    end

    CSV.foreach('lib/plant_coach_guides.csv', :headers => true) do |row|
      PlantCoachGuide.create(row.to_hash)
    end
  end
end
