class MessageMailer < ApplicationMailer

    default from: 'your_email@example.com'

    def welcome_email(message)
      @message = Message.find(message)
      @url  = 'http://example.com/login'
      mail(to: @message.receiver.email, subject: 'Welcome to My Awesome Site')
    end

end
