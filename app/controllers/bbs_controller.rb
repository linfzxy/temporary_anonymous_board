class BbsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def paging
    @messages=Message.order(id: :desc).limit(30).offset(params[:page]*30)
  end

  def new_message
    render plain:'false' and return if params[:content].length>3000
    render plain:User.new_message(params[:nickname],params[:verifyword],params[:content],request.remote_ip)
  end
end
