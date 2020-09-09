class Company < ApplicationRecord
  validates :name, :domain, presence: true
end
