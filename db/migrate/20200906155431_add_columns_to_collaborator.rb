class AddColumnsToCollaborator < ActiveRecord::Migration[6.0]
  def change
    add_column :collaborators, :full_name, :string
    add_column :collaborators, :social_name, :string
    add_column :collaborators, :birth_date, :date
    add_column :collaborators, :role, :string
    add_column :collaborators, :department, :string
    add_reference :collaborators, :company, null: false, foreign_key: true
    add_column :collaborators, :status, :integer
  end
end
