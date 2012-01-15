SndTimetracking::Application.routes.draw do


  resources :sessions, :only => [:new,:create,:destroy]
  resources :pages, :only => [:home,:chatter,:profile]

  match '/home', :to => 'pages#home'
  match '/profile', :to => 'pages#profile'
  match '/chatter', :to => 'pages#chatter'

  match '/signin',  :to => 'sessions#authenticateSF'
  match '/signout',  :to => 'sessions#destroy'
  match '/signoutsf',  :to => 'sessions#signout_revoke'
  match '/signoutexp', :to => 'sessions#signout_exp'

  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#fail'

  root :to => 'pages#home'
end
