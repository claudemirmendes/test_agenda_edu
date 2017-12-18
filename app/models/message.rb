class Message < ApplicationRecord
 scope :by_user_received, -> (user_received_id) { where(user_received_id: user_received_id) }
 scope :not_archive, -> { where(:archive => false) }

 def self.create_message(message_params,user)
   user_received = User.where(email: message_params[:user_received_id]).first
   if !user_received.blank?
     message = Message.new(message_params)
     message.user_send_id = user.id
     message.user_received_id = user_received.id
     self.generate_date_send(message)
     message.read = false
     message.save
   end
 end

 def self.archive(message_id)
   message = Message.find(message_id)
   message.update(archive: true)
 end

 def self.generate_date_send(message)
   date = Time.zone.now - 3.hours 
   message.update(date_send: date)
 end

def self.archive_all(messages)
  messages.each do |message|
    message.update(archive: true)
  end
end

def self.set_read(params)
  date = Time.zone.now - 3.hours
  message = Message.find(params[:id])
  message.update(date_read: date)
  message.update(read: true)
end
end
