Rails.application.routes.draw do
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :posts, only: [:new, :create, :index]

  root 'users#new'

end
