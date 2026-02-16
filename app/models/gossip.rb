class Gossip < ApplicationRecord
  belongs_to :user

  validates :title, :content, :user_id, presence: true

  has_many :gossip_tags
  has_many :tags, through: :gossip_tags

  has_many :comments

  # Likes (polymorphic)
  has_many :likes, as: :likeable
end
