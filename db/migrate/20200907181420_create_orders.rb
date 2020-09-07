class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :collaborator, null: false, foreign_key: true
      t.integer :status, default: 0
      t.float :value
      t.references :order_messages, foreign_key: true
      t.date :order_date
      t.date :sell_date

      t.timestamps
    end
  end
end
