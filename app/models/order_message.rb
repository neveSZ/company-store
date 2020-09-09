class OrderMessage < ApplicationRecord
  belongs_to :collaborator
  belongs_to :order
  before_validation :set_date, :set_type
  validates :text, :collaborator, :order, :date, :collaborator_type, presence: true

  enum collaborator_type: {
    'Vendedor(a)': 0,
    'Comprador(a)': 1
  }

  private def set_type
    self.collaborator_type = if collaborator != order.collaborator
                               'Vendedor(a)'
                             else
                               'Comprador(a)'
                             end
  end

  private def set_date
    self.date = Time.current
  end
end
