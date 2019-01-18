Rails.application.routes.draw do  
	
  get 'tags/new'
  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'user/:id', to: 'user#show', as: 'user'
  root to: "sessions#new"
  
  resources :questions do
		  resources :answers
  end
  resources :user_teams
  resources :teams

end