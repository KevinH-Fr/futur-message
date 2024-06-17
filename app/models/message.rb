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
  after_save :schedule_sms

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
    MessageMailer.receiver_scheduled_email(self.id).deliver_later
  end

  def schedule_email
    if mail?
      EmailJob.set(wait_until: self.sent_at).perform_later(self.id)
    end
  end

  def schedule_sms
    if sms?
      to = "+33671793932"  # Replace with actual recipient number
      body = "test contenu message"  # Replace with actual message content
      sms_sender = SmsService.new(to, body)
      result = sms_sender.send_sms
    end
  end

end
