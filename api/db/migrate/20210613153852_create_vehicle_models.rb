class CreateVehicleModels < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicle_models do |t|
      t.references :brand, null: false, foreign_key: {to_table: :vehicle_brands}
      t.string :name

      t.timestamps
    end
  end
end
