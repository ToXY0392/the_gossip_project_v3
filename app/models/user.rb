class User < ApplicationRecord
  belongs_to :city

  has_many :gossips
  has_many :comments

  # Private Messages (sender + recipients)
  has_many :sent_private_messages, class_name: "PrivateMessage", foreign_key: "sender_id"

  has_many :private_message_recipients, foreign_key: "recipient_id"
  has_many :received_private_messages, through: :private_message_recipients, source: :private_message

  # Likes
  has_many :likes
end
