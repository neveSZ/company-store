class Collaborator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :company
  before_validation :add_company

  private def add_company
    if email.present?
      domain = email.split('@').last
      company = Company.find_by(domain: domain)
      unless company.present?
        company = Company.new(domain: domain, name: domain.split('.').first)
      end 
      self.company = company
    end
  end
end
