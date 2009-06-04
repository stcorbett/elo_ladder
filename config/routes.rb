ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'users'

  map.resources :users
  map.resources :games
  
  map.resources :user_sessions
  map.resources :password_resets
  
  map.register '/register', :controller => 'users', :action => 'new'
  map.profile '/profile',   :controller => 'users', :action => 'edit'
  
  map.login '/login',   :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
