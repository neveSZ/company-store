class OrderMessage < ApplicationRecord
  belongs_to :collaborator
  belongs_to :order
end
