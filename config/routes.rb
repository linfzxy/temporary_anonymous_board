Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect( '/bbs/0')
  get '/bbs/:page', to: 'bbs#paging'
  post '/bbs/new', to: 'bbs#new_message'
end
