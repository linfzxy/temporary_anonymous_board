class User < ApplicationRecord

  def self.new_message nickname,content,ip
    Message.new(:content => content, :author => nickname , :ctime => Time.now.to_datetime, :ip => ip, :replycount => 0 , :lastreply => Time.now.to_i).save
    return true
  end


  def self.verify nickname,verifyword,ip='0.0.0.0'
    return false if Iptable.ban? ip,0
    return true if nickname.blank? || nickname=='Anonymous'
    user=User.where(:nickname => nickname).last
    if user==nil || user.verifyword.blank? || user.activitydate< Time.now.to_i-2592000
      if verifyword.blank?
        return true
      end
      User.new(:nickname => nickname, :verifyword => verifyword , :ip => ip, :activitydate => Time.now).save
      Iptable.ban? ip,20
      return true
    elsif user.verifyword == verifyword
     user.activitydate=Time.now
     user.save
     return true
    end
    return false
  end
end
