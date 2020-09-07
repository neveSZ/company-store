class CreateProductMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :product_messages do |t|
      t.references :collaborator, null: false, foreign_key: true
      t.string :texto
      t.string :date

      t.timestamps
    end
  end
end
