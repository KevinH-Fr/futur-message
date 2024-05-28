class Message < ApplicationRecord
  # Associations
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'

  # Validations (optional)
  validates :title, presence: true
  validates :content, presence: true
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :sent_at, presence: true
  
end
