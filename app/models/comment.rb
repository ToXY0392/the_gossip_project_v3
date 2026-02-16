class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :gossip

  validates :content, :user_id, :gossip_id, presence: true

  # Likes (polymorphic)
  has_many :likes, as: :likeable
end
