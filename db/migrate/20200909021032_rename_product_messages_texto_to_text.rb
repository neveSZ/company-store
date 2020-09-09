class RenameProductMessagesTextoToText < ActiveRecord::Migration[6.0]
  def change
    rename_column :product_messages, :texto, :text
  end
end
