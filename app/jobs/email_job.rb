class EmailJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find(message_id)
    MessageMailer.welcome_email(message.id).deliver_now
  end
end
