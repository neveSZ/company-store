class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.references :category, null: false, foreign_key: true
      t.json :images
      t.string :description
      t.string :value
      t.integer :status, default: 0
      t.references :product_messages, foreign_key: true
      t.references :collaborator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
