class OrderMessage < ApplicationRecord
  belongs_to :collaborator
  belongs_to :order
  after_create :set_type
  validates :text, presence: true

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
    save
  end
end
