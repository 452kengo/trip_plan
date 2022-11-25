class AddDetailToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :row_order, :integer
  end
end
