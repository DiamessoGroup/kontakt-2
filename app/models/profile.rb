class Profile < ApplicationRecord
  # Association
  belongs_to :user

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Methods
  def full_address
    "#{address}, #{city}, #{state} #{zip_code}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
