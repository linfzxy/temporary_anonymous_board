class Iptable < ApplicationRecord

  def self.ban? ip
    iptable=Iptable.where(:ip => ip).first
    if iptable==nil
      Iptable.new(:ip => ip, :counter => 1, :lowerbounder => Time.now, :banned => false).save
      return false
    elsif iptable.banned== true
      iptable.counter+=1
      iptable.lowerbounder=Time.now
      iptable.save
      return true
    elsif iptable.counter<=50
      iptable.counter+=1
      iptable.save
      return false
    elsif ( Time.now - iptable.lowerbounder > 10.minutes )
      iptable.counter=0
      iptable.lowerbounder=Time.now
      iptable.save
      return false
    end
    return true
  end
end
