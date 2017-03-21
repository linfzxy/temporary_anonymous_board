Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect( '/bbs/pages/0')
  get '/bbs/pages/:page', to: 'bbs#paging'
  get '/bbs/pages', to: redirect( '/bbs/pages/0')

  get '/bbs/message/:message_id', to:'bbs#message'

  post '/bbs/new', to: 'bbs#new_message'
  post '/bbs/signin', to: 'bbs#signin'
  get 'bbs/logout', to: 'bbs#logout'
  get 'bbs/:message_id/reply', to: 'bbs#get_reply'
  post 'bbs/:message_id/reply', to: 'bbs#reply'

  get 'bbs/article/:id', to: 'articles#distribute'


  get '/bbs/admin/delete_message/:id', to:'admin#delete_message'
  get '/bbs/admin/add_to_ban_list/:ip1/:ip2/:ip3/:ip4', to:'admin#add_to_ban_list'
  get '/bbs/admin/remove_from_ban_list/:ip1/:ip2/:ip3/:ip4', to:'admin#remove_from_ban_list'

end
