class AddCollaboratorTypeToOrderMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :order_messages, :collaborator_type, :integer
  end
end
