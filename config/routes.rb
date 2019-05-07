# frozen_string_literal: true

Rails.application.routes.draw do
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :posts, only: %i[new create index]

  root 'users#new'
end
