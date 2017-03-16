class User < ApplicationRecord

  def self.new_message nickname,verifyword,content,ip
    return false if !User.verify nickname,verifyword,ip
    Message.new(:content => content, :author => nickname , :ctime => Time.now, :ip => ip).save
    return true
  end


  def self.verify nickname,verifyword,ip='0.0.0.0'
    return false if Iptable.ban? ip
    return true if nickname=='anonymous'
    user=User.where(:nickname => nickname).last
    if user==nil || user.verifyword.blank?
      User.new(:nickname => nickname, :verifyword => verifyword , :ip => ip, :activitydate => Time.now).save
      return true
    elsif user.verifyword == verifyword
     user.activitydate=Time.now
     user.save
     return true
    end
    return false
  end
end
