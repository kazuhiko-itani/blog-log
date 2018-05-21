Rails.application.routes.draw do

  get 'sessions/new'

  root 'users#index'
  get 'help' => 'home#help'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  delete 'logout' => 'sessions#destroy'

  # Twitterでのログイン
  get 'auth/:provider/callback' => 'sessions#create'

  resources :users do
    # 検索処理アクション
    collection do
      get :search_form
      get :search_result
    end
  end
  resources :posts

  # テスト用ログインアクション
  get 'login' => 'sessions#new'
  post 'test/login' => 'sessions#login'
end
