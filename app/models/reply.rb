class Reply < ApplicationRecord
  def self.new_reply message_id,author,content,ip
    Reply.new(:message => message_id, :author => author, :content=> content, :ctime => Time.now.to_i, :ip => ip).save
  end
end
