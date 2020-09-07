class Order < ApplicationRecord
  belongs_to :collaborator
  has_many :order_messages
  belongs_to :product
  before_create :set_init_value
  after_create :set_product_status

  enum status: {
    negotiation: 0,
    completed: 1,
    canceled: 2
  }

  private def set_init_value
    self.value = product.value
  end

  def set_product_status
    product.status = 3
    product.save!
  end
end
