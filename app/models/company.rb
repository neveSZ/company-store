class Company < ApplicationRecord
  validates :name, :domain, presence: true
  validates :domain, uniqueness: true
end
