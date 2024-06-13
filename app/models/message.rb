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
  
  after_save :schedule_email, if: :saved_change_to_sent_at?
  after_save :deliver_email

  def past?
    sent_at <= Time.current
  end

  def upcoming?
    sent_at > Time.current
  end
  
  
  private

  def deliver_email
    MessageMailer.sender_scheduled_email(self.id).deliver_later
    MessageMailer.receiver_delivered_email(self.id).deliver_later
  end

  def schedule_email
    EmailJob.set(wait_until: self.sent_at).perform_later(self.id)
  end
  
end
