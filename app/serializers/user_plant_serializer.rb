class UserPlantSerializer
  include JSONAPI::Serializer
  attributes :id, :user_id, :plant_id

  def self.format(user, plant)
    {
      "data": {
        "attributes": {
          "user": user.name,
          "user_id": user.id,
          "plant": plant.name,
          "plant_id": plant.id
        }
      }
    }
  end

  def self.error(message)
    {
      "error": message
    }
  end
end
