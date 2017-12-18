json.extract! message, :id, :send, :read, :date_send, :date_read, :text, :user_id, :user_send_id, :user_received_id, :created_at, :updated_at
json.url message_url(message, format: :json)
