class AdminController < ApplicationController
  http_basic_authenticate_with name:'change_to_your_own',password:'change_to_your_own'
  def delete_message
    Message.delete(params[:id])
    render plain:'ok'
  end
  def add_to_ban_list
    ip=params[:ip1]+'.'+params[:ip2]+'.'+params[:ip3]+'.'+params[:ip4]
    iptable=Iptable.where(:ip => ip).first
    if iptable!=nil
      iptable.banned=true
    else
      iptable=Iptable.new(:ip => ip, :counter => 0, :lowerbounder => Time.now.to_i, :banned => true)
    end
    iptable.save
    render plain:'ok'
  end
  def remove_from_ban_list
    ip=params[:ip1]+'.'+params[:ip2]+'.'+params[:ip3]+'.'+params[:ip4]
    Iptable.where(:ip => ip).destroy_all
    render plain:'ok'
  end

end
