class DropTransplantGuides < ActiveRecord::Migration[5.2]
  def change
    drop_table :transplant_guides
  end
end
