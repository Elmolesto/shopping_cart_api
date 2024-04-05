class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description
      t.string :thumbnail
      t.string :type
      t.integer :price_cents, null: false
      t.jsonb :details, default: {}

      t.timestamps
    end
  end
end
