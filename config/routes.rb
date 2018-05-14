Rails.application.routes.draw do

  get 'sessions/new'

  root 'home#top'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  delete 'logout' => 'sessions#destroy'

  # Twitterでのログイン
  get 'auth/:provider/callback' => 'sessions#create'

  resources :users

  # テスト用ログインルート
  get 'login' => 'sessions#new'
  post 'test/login' => 'sessions#login'
end
