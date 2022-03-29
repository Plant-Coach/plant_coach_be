class UserPlantSerializer
  include JSONAPI::Serializer


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
