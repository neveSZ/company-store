class ProductMessage < ApplicationRecord
  belongs_to :collaborator
  belongs_to :product
  validates :text, :date, :product, presence: true
  before_validation :set_date

  private def set_date
    self.date = Time.current
  end
end
