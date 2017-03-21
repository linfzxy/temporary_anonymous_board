class BbsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def message
    @message=Message.find(params[:message_id].to_i)
    @replies=Reply.order(:id).where(:message => params[:message_id].to_i)
    render 'bbs/message'
  end

  def paging
    @messages=Message.order(lastreply: :desc).limit(15).offset(params[:page].to_i*15)
    @page=params[:page].to_i
  end

  def get_reply
    @replies=Reply.order(:id).where(:message => params[:message_id].to_i)
    render 'bbs/replies'
  end
  def reply
    message_id=params[:message_id].to_i
    content=params['reply-content']
    if content.blank? || content.length>300
      @errormsg='回复不能为空/过长。'
      render 'comments/error_page' and return
    end
    if Iptable.ban? request.remote_ip,1
      @errormsg='猜猜你是回帖太快还是被ban？'
      render 'comments/error_page' and return
    end
    nickname=session[:nickname].blank? ? 'Anonymous' : session[:nickname]
    Reply.new_reply message_id,nickname,content,request.remote_ip
    Message.count_inc message_id
    redirect_to '/bbs/message'+message_id.to_s
  end

  def signin
    nickname= params[:nickname].blank? ? 'Anonymous' : params[:nickname]
    verifyword= params[:verifyword].blank? ? '' : params[:verifyword]
    if nickname.length>25
      @errormsg='nickname过长。'
      render 'comments/error_page' and return
    end
    flag=User.verify nickname,verifyword,request.remote_ip
    if flag
      cookies[:nickname] = { :value => nickname, :expires => 3.weeks.from_now }
      cookies[:verifyword] = { :value => verifyword, :expires => 3.weeks.from_now }
      session[:nickname]=nickname
      redirect_to root_url and return
    end
    @errormsg='您可能是盗版软件的受害者/您想使用的nickname的verifyword输入错误或已过期/您可能玩用户名过快/我们可能已经拉黑了你了(手动微笑)。'
    render 'comments/error_page'
  end

  def logout
    reset_session
    cookies.delete :nickname
    cookies.delete :verifyword
    redirect_to root_url and return
  end

  def new_message
    if params[:content].blank?||params[:content].length>3000
      @errormsg='您的内容为空或者过长。'
      render 'comments/error_page' and return
    end
    if Iptable.ban? request.remote_ip,10
      @errormsg='猜猜你是发帖太快还是被ban？'
      render 'comments/error_page' and return
    end
    content= (!params['markdown'].blank? && params['markdown']=='true') ? markdown(params[:content]) : params[:content]
    nickname=session[:nickname].blank? ? 'Anonymous' : session[:nickname]
    htmlfilter content
    User.new_message(nickname,content,request.remote_ip)
    redirect_to root_url
  end

  private
  def htmlfilter content
    content.gsub! "\r\n",'<br/>'
    # content.gsub! " ","&nbsp;"     #空格转换 不过可能跟html的标签有冲突 先不用了
  end
  def markdown(text)
    options = {
        :autolink => true,
        :space_after_headers => true,
        :fenced_code_blocks => true,
        :no_intra_emphasis => true,
        :hard_wrap => true,
        :strikethrough =>true
    }
    markdown = Redcarpet::Markdown.new(HTMLwithCodeRay,options)
    puts markdown.methods
    markdown.render(text).html_safe
  end

  class HTMLwithCodeRay < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div(:tab_width=>2)
    end
  end

end

