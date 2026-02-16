class City < ApplicationRecord
  has_many :users

  validates :name, :zip_code, presence: true
end
