class Order < ApplicationRecord
  belongs_to :collaborator
  has_many :order_messages
  belongs_to :product
  before_create :set_init_value, :set_order_date
  after_create :set_negotiation

  enum status: {
    negotiation: 0,
    completed: 1,
    canceled: 2
  }

  private def set_init_value
    self.value = product.value
  end

  private def set_order_date
    self.order_date = Time.now
  end

  def set_negotiation
    product.set_negotiation
    self.status = 'negotiation'
    save
  end

  def set_completed
    product.set_sold
    self.status = 'completed'
    save
  end

  def set_canceled
    product.set_avaliable
    self.status = 'canceled'
    save
  end
end
