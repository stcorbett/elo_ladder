ActionController::Routing::Routes.draw do |map|

  map.root :controller => "users", :action => "index"

  map.resources :users
  map.resources :user_sessions
  map.resources :password_resets
  map.resources :games
  
  map.resource :account, :controller => "users"
  
  map.login     '/login',    :controller => "user_sessions", :action => "new"
  map.logout    '/logout',   :controller => "user_sessions", :action => "destroy"
  map.register  '/register', :controller => "users",         :action => "new"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
