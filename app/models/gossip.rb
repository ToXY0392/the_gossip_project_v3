class Gossip < ApplicationRecord
  belongs_to :user

  validates :title, :content, :user_id, presence: true

  has_many :gossip_tags, dependent: :destroy
  has_many :tags, through: :gossip_tags, dependent: :destroy

  has_many :comments, dependent: :destroy

  # Likes (polymorphic)
  has_many :likes, as: :likeable, dependent: :destroy
end
