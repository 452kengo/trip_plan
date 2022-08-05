class AddDoneToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :done, :boolean
  end
end
