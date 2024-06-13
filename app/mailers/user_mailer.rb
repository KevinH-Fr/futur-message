class UserMailer < ApplicationMailer
    default from: 'your_email@example.com'

    def welcome_email(user)
      @user = User.find(user.id)
      @url = "https://futur-message-ecb35003e1a0.herokuapp.com/"
      mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end
  end
  