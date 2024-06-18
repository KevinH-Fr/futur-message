# app/jobs/sms_job.rb
class SmsJob < ApplicationJob
    queue_as :default
  
    def perform(message_id)

      message = Message.find(message_id)
      to = message.receiver_phone_number  
      sender_name = message.sender.name

      body = message.content 
      sms_sender = SmsService.new(to, body, sender_name)
      result = sms_sender.send_sms
    end
  end
  
