class Message < ApplicationRecord
  # Associations
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id', optional: true

  has_one_attached :document

  validate :document_format_and_size

  # Validations (optional)
  validates :content, presence: true
  validates :sender_id, presence: true
  validates :sent_at, presence: true

  validate :validate_receiver_mail_if_message_mail
  validate :validate_receiver_phone_if_message_sms


  scope :past, -> { where('sent_at <= ?', Time.current) }
  scope :upcoming, -> { where('sent_at > ?', Time.current) }

  after_save :schedule_email, if: :saved_change_to_sent_at?
  after_save :schedule_sms, if: :saved_change_to_sent_at?

  after_save :deliver_email

  def past?
    sent_at <= Time.current
  end

  def upcoming?
    sent_at > Time.current
  end

  def receiver_label
    if receiver
      receiver.name
    elsif receiver_mail
      receiver_mail
    elsif receiver_phone_number
      receiver_phone_number
    end
  end

  def document_format_and_size
    if document.attached?
      unless document.blob.content_type.in?(%w(image/jpeg image/png image/gif))
        errors.add(:document, 'must be a JPEG, PNG, or GIF image')
      end
      unless document.blob.byte_size <= 2.megabyte
        errors.add(:document, 'size should be less than 2MB')
      end
    end
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
      SmsJob.set(wait_until: self.sent_at).perform_later(self.id)
    end
  end

  def validate_receiver_mail_if_message_mail
    if mail && receiver_mail.blank?
      errors.add(:receiver_mail, "can't be blank if message.mail is true")
    end
  end

  def validate_receiver_phone_if_message_sms
    if sms && receiver_phone_number.blank?
      errors.add(:receiver_phone_number, "can't be blank if message.sms is true")
    end
  end



end
