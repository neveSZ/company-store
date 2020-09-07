class Product < ApplicationRecord
  belongs_to :category
  has_many :product_messages
  belongs_to :collaborator
  mount_uploaders :images, ImageUploader
  validates :name, :category_id, :description, :value, :status, :collaborator_id, presence: true

  enum status: {
    avaliable: 0,
    inactive: 1,
    sold: 2,
    negotiation: 3
  }
  # serialize :images, JSON
end
