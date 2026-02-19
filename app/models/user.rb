class User < ApplicationRecord
  has_secure_password

  belongs_to :city

  validates :first_name, :last_name, :email, :city_id, presence: true
  validates :email, uniqueness: true
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  has_many :gossips
  has_many :comments

  # Private Messages (sender + recipients)
  has_many :sent_private_messages, class_name: "PrivateMessage", foreign_key: "sender_id"

  has_many :private_message_recipients, foreign_key: "recipient_id"
  has_many :received_private_messages, through: :private_message_recipients, source: :private_message

  # Likes
  has_many :likes
end
