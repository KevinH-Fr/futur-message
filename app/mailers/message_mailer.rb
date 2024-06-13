class MessageMailer < ApplicationMailer

    default from: 'your_email@example.com'
    
    def sender_scheduled_email(message)
      @message = Message.find(message)
      @url = "https://futur-message-ecb35003e1a0.herokuapp.com/"
      mail(to: @message.sender.email, subject: "L'envoi de votre message a bien été programmé")
    end

    def sender_delivered_email(message)
      @message = Message.find(message)
      subject = 
      mail(to: @message.sender.email, subject: 'Votre message a bien été envoyé')
    end

    def receiver_scheduled_email(message)
      @message = Message.find(message)
      mail(to: @message.receiver.email, subject: "Vous message pour le futur")
    end

    def receiver_delivered_email(message)
      @message = Message.find(message)
      mail(to: @message.receiver.email, subject: 'Votre nouveau message est lisible')
    end

end
