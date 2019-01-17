Rails.application.routes.draw do
  get 'questions/new'
	  resources 'questions' do
		  resources 'answers'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  root to: "sessions#new"
end
