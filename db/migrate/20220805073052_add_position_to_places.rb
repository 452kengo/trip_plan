class AddPositionToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :position, :integer
  end
end
