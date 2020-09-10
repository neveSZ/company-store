class Product < ApplicationRecord
  belongs_to :category
  has_many :product_messages
  belongs_to :collaborator
  mount_uploaders :images, ImageUploader
  validates :name, :category, :description, :status, :collaborator_id, presence: true
  validates :value, numericality: { greater_than_or_equal_to: 0.00 }, presence: true

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
