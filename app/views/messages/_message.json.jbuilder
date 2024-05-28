json.extract! message, :id, :title, :content, :sender_id, :receiver_id, :sent_at, :created_at, :updated_at
json.url message_url(message, format: :json)
