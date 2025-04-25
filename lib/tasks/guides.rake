require 'csv'

namespace :guides do
  desc 'Create Plant Guides Objects'
  task create_plant_guides: :environment do
    PlantGuideMaster.destroy_all

    CSV.foreach('lib/PlantGuideMaster.csv', headers: true) do |row|
      PlantGuideMaster.create(row.to_hash)
    end
  end
end
