# app/services/sms_service.rb
class SmsService
    require 'twilio-ruby'  # Ensure this line is present
  
    def initialize(to, body, sender_name)
      @to = to
      @body = body
      @sender_name = sender_name
      @account_sid = ENV['TWILIO_ACCOUNT']
      @auth_token = ENV['TWILIO_AUTH_TOKEN']
      @from = ENV['TWILIO_PHONE_NUMBER']
    end
  
    def send_sms

      client = Twilio::REST::Client.new(@account_sid, @auth_token)
  
      message = client.messages.create(
        from: @from,
        to: @to,
        body: "message: #{@body} - envoyé par: #{@sender_name} - futurmessage.com"
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
  