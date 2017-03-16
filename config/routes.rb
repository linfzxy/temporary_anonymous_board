Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect( '/bbs/0')
  get '/bbs/:page', to: 'bbs#paging'
  post '/bbs/new', to: 'bbs#new_message'

  get '/bbs/admin/delete_message/:id', to:'admin#delete_message'
  get '/bbs/admin/add_to_ban_list/:ip1/:ip2/:ip3/:ip4', to:'admin#add_to_ban_list'
  get '/bbs/admin/remove_from_ban_list/:ip1/:ip2/:ip3/:ip4', to:'admin#remove_from_ban_list'

end
