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

  def set_negotiation
    self.status = 'negotiation'
    save
  end

  def set_inactive
    self.status = 'inactive'
    save
  end

  def set_sold
    self.status = 'sold'
    save
  end

  def set_avaliable
    self.status = 'avaliable'
    save
  end

  # serialize :images, JSON
end
