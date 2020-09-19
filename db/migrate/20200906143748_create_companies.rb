class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :domain
      t.string :name

      t.timestamps
    end
  end
end
