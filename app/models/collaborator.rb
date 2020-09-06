class Collaborator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :company
  before_validation :add_company
  before_save :set_status

  enum status: {
    inactive: 0,
    active: 1
  }

  private def add_company
    if email.present?
      domain = email.split('@').last
      company = Company.find_by(domain: domain)
      company = Company.new(domain: domain, name: domain.split('.').first) unless company.present?
      self.company = company
    end
  end

  private def set_status
    self.status = if department.present? && role.present? && birth_date.present? && (full_name.present? || social_name.present?)
                    1
                  else
                    0
                  end
  end
end
