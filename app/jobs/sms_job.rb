# app/jobs/sms_job.rb
class SmsJob < ApplicationJob
    queue_as :default
  
    def perform(message_id)

      message = Message.find(message_id)
      to = "+33671793932"  # Replace with actual recipient number
      body = message.content # Replace with actual message content
      sms_sender = SmsService.new(to, body)
      result = sms_sender.send_sms
    end
  end
  
