class City < ApplicationRecord
  has_many :users
  has_many :gossips, through: :users

  validates :name, :zip_code, presence: true
end
