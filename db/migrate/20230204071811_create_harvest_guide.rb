class CreateHarvestGuide < ActiveRecord::Migration[5.2]
  def change
    create_table :harvest_guides do |t|
      t.date :when
      t.string :how
      t.string :harvest_time
    end
  end
end
