class AddProductToProductMessages < ActiveRecord::Migration[6.0]
  def change
    add_reference :product_messages, :product, null: false, foreign_key: true
  end
end
