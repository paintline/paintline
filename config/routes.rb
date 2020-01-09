Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'home#paint_list'

  #新規登録
  get '/sign_up' => 'users#sign_up', as: :sign_up
  post '/sign_up' => 'users#sign_up_process'
  
  #サインイン
  get '/sign_in' => 'users#sign_in', as: :sign_in
  post '/sign_in' => 'users#sign_in_process'
  
  #サインアウト
  get '/sogn_out' => 'users#sign_out', as: :sign_out

#投稿作品関連-----------------------------------------------

  resources :sengas
  
  #線画一覧
  get 'senga/list' => 'home#senga_list', as: :senga_list
  
  #お気に入り
  get 'senga/like/(:id)' => 'sengas#senga_like', as: :senga_like
  get 'paint/like/(:id)' => 'paints#paint_like', as: :paint_like
  
  resources :paints
  
  get 'paint/list' => 'home#paint_list', as: :paint_list
  
  get 'create/:id/png' => 'home#create_png', as: :create_png
  
  delete 'sengas/(:id)' => 'senngas#destroy'
  
#新規投稿-----------------------------------------------

  get 'new/:model' => 'home#new', as: :new 

#通知-----------------------------------------------

 get '/event' => 'event#notification', as: :event
  
#プロフィール-----------------------------------------------

  get '/profile/edit' => 'users#profile_edit', as: :profile_edit

  get '/profile/(:id)' => 'users#profile', as: :profile
  
  patch '/profile/edit' => 'users#update'

#申請-----------------------------------------------

  get '/senga_request/:senga_id' => 'sengas#senga_request', as: :senga_request
  
  #許可
  get '/senga_request/commit/:request_id' => 'sengas#senga_request_commit', as: :senga_request_commit
  
  #不許可
  get '/senga_request/deny/:request_id' => 'sengas#senga_request_deny', as: :senga_request_deny
end
