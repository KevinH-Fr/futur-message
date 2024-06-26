class EmailJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find(message_id)
    MessageMailer.sender_delivered_email(message.id).deliver_later
    MessageMailer.receiver_delivered_email(message.id).deliver_later
  end
end
