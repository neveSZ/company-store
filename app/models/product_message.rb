class ProductMessage < ApplicationRecord
  belongs_to :collaborator
  belongs_to :product
  validates :text, presence: true
end
