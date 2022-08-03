class AddReferencesToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_reference :places, :plan, foreign_key: true
  end
end
