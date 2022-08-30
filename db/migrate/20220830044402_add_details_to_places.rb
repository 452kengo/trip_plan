class AddDetailsToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :departure_time, :time
    add_column :places, :arrival_time, :time
  end
end
