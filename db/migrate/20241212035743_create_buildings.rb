class CreateBuildings < ActiveRecord::Migration[7.2]
  def change
    create_table :buildings do |t|
      t.string :street_1, null: false
      t.string :street_2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zipcode, null: false
      t.jsonb :custom_fields, null: false, default: {}
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
