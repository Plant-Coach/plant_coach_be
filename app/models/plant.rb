class Plant < ApplicationRecord
  validates_presence_of :name,
                        :plant_type,
                        :days_to_maturity,
                        :hybrid_status,
                        :days_relative_to_frost_date
  validates_inclusion_of :organic, in: [true, false]
  # Records must be unique according to name, but only unique for those that
  # belong to each user (aka "user_id").
  validates :name, presence: true, uniqueness: { scope: :user_id }

  belongs_to :user

  enum hybrid_status: [:open_pollinated, :f1]
  # enum organic: [true, false]
end
