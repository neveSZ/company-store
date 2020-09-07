class CreateOrderMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :order_messages do |t|
      t.references :collaborator, null: false, foreign_key: true
      t.string :text
      t.date :date
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
