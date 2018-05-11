Rails.application.routes.draw do

  root 'home#top'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

  resources :users
end
