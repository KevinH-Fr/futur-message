class Message < ApplicationRecord
  # Associations
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'

  has_one_attached :document

  # Validations (optional)
  validates :content, presence: true
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :sent_at, presence: true
  
  scope :past, -> { where('sent_at <= ?', Time.current) }
  scope :upcoming, -> { where('sent_at > ?', Time.current) }
  
  def past?
    sent_at <= Time.current
  end

  def upcoming?
    sent_at > Time.current
  end
  
end
