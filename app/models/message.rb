class Message < ApplicationRecord
  def self.count_inc id
    message=Message.find(id)
    message.replycount+=1
    message.lastreply=Time.now.to_i
    message.save
  end
end