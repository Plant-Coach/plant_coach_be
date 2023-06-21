class AddFrostDatesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :spring_frost_date, :string
    add_column :users, :fall_frost_date, :string
  end
end
