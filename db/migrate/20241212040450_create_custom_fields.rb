class CreateCustomFields < ActiveRecord::Migration[7.2]
  def change
    create_table :custom_fields do |t|
      t.string :name, null: false
      t.string :display_name, null: false
      t.integer :field_type, null: false, default: 0
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
