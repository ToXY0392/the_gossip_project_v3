class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :gossip

  # Likes (polymorphic)
  has_many :likes, as: :likeable
end
