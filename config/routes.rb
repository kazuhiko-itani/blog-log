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
    # フォロー表示ページ
    member do
      get :following
    end
  end
  resources :posts
  resources :relationships, only: [:create, :destroy]

  # テスト用ログインアクション
  if Rails.env.test?
    post 'test/login' => 'sessions#login'
  end
end
