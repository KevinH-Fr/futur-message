# app/services/sms_service.rb
class SmsService
    require 'twilio-ruby'  # Ensure this line is present
  
    def initialize(to, body, sender_name)
      @to = to
      @body = body
      @sender_name = sender_name
      @account_sid = Rails.application.credentials.twilio_account
      @auth_token = Rails.application.credentials.twilio_auth_token
      @from = Rails.application.credentials.twilio_phone_number
    end
  
    def send_sms

      client = Twilio::REST::Client.new(@account_sid, @auth_token)
  
      message = client.messages.create(
        from: @from,
        to: @to,
        body: "message: #{@body} - de: #{@sender_name}"
      )
  
      if message.sid
        { status: 'Message sent', sid: message.sid }
        puts "_______________sms sent __________"

      else
        { status: 'Failed to send message', error: 'Unknown error' }
        puts "_______________sms not sent __________"

      end
    rescue StandardError => e
      { status: 'Failed to send message', error: e.message }
    end
  end
  