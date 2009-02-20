ActionController::Routing::Routes.draw do |map|

  map.root :controller => "users", :action => "index"

  map.resource :account, :controller => "users"
  map.resource :user_session

  map.resources :users
  
  map.login '/login', :controller => "user_sessions", :action => "new"
  map.logout '/logout', :controller => "user_sessions", :action => "destroy"
  map.register '/register', :controller => "users", :action => "new"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
