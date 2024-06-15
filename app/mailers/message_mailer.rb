class MessageMailer < ApplicationMailer
  default from: 'contact.futurmessage@gmail.com'
  BASE_URL = 'https://futur-message-ecb35003e1a0.herokuapp.com/'

  def sender_scheduled_email(message_id)
    setup_message_and_url(message_id)
    mail(to: @message.sender.email, subject: "L'envoi de votre message a bien été programmé")
  end

  def sender_delivered_email(message_id)
    setup_message_and_url(message_id)
    mail(to: @message.sender.email, subject: 'Votre message a bien été envoyé')
  end

  def receiver_scheduled_email(message_id)
    setup_message_and_url(message_id)
    mail(to: @message.receiver.email, subject: "Votre message pour le futur")
  end

  def receiver_delivered_email(message_id)
    setup_message_and_url(message_id)
    mail(to: @message.receiver.email, subject: 'Votre nouveau message est lisible')
  end

  private

  def setup_message_and_url(message_id)
    @message = Message.find(message_id)
    @url = BASE_URL
  end
end
