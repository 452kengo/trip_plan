class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :title
      t.datetime :plan_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
