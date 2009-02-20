ActionController::Routing::Routes.draw do |map|

  map.resource :account, :controller => "users"
  map.resource :user_session

  map.resources :users
  
  map.login :controller => "user_sessions", :action => "new"
  map.logout :controller => "user_sessions", :action => "destroy"
  map.register :controller => "users", :action => "new"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
