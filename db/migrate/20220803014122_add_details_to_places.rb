class AddDetailsToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :arrivalTime, :time
    add_column :places, :departureTime, :time
  end
end
