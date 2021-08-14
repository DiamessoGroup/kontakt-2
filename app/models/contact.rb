# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true

  # Will paginate per 5 pages
  self.per_page = 5
end
