class Profile < ApplicationRecord
  # Association
  belongs_to :user

  has_one_attached :avatar

  # Callbacks
  # Strip First Name and Last Name of spaces
  before_save do
    self.first_name = first_name.strip
    self.last_name = last_name.strip
  end

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

  def avatar_attached?
    avatar.attached? ? avatar : 'avatar-3.png'
  end

end
