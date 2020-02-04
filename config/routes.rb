Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #線画一覧
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
  
  #削除
  delete 'sengas/(:id)' => 'senngas#destroy', as: :senga_delete
  
#新規投稿-----------------------------------------------

  get 'new/:model' => 'home#new', as: :new 

#通知-----------------------------------------------

 get '/event' => 'event#notification', as: :event
  
#プロフィール-----------------------------------------------

  #編集
  get '/profile/edit' => 'users#profile_edit', as: :profile_edit

  get '/profile/(:id)' => 'users#profile', as: :profile
  
  patch '/profile/edit' => 'users#update'

#申請-----------------------------------------------

  #申請一覧
  get '/sinsei_list/(:id)' => 'home#sinsei_list', as: :sinsei_list

  #申請する
  get '/senga_request/:senga_id' => 'sengas#senga_request', as: :senga_request
  
  #許可
  get '/senga_request/commit/:request_id' => 'sengas#senga_request_commit', as: :senga_request_commit
  
  #不許可
  get '/senga_request/deny/:request_id' => 'sengas#senga_request_deny', as: :senga_request_deny
  
#ヘルプ-----------------------------------------------

  #メインヘルプ画面
  get '/help' => 'help#user_help', as: :user_help
  
  #メインヘルプ1
  get '/main_help1' => 'help#main_help1', as: :main_help1

  #メインヘルプ2
  get '/main_help2' => 'help#main_help2', as: :main_help2

  #メインヘルプ3
  get '/main_help3' => 'help#main_help3', as: :main_help3

  #メインヘルプ4
  get '/main_help4' => 'help#main_help4', as: :main_help4

  #naviヘルプ--------------------------------------------
  
  #ナビヘルプ1
  get '/navi_help1' => 'help#navi_help1', as: :navi_help1

  #ナビヘルプ2
  get '/navi_help2' => 'help#navi_help2', as: :navi_help2

  #ナビヘルプ3
  get '/navi_help3' => 'help#navi_help3', as: :navi_help3

  #ナビヘルプ4
  get '/navi_help4' => 'help#navi_help4', as: :navi_help4

  #ナビヘルプ5
  get '/navi_help5' => 'help#navi_help5', as: :navi_help5

  #ナビヘルプ6
  get '/navi_help6' => 'help#navi_help6', as: :navi_help6

  #ポストヘルプ--------------------------------------------

  #ポストヘルプ1
  get '/post_help1' => 'help#post_help1', as: :post_help1

  #ポストヘルプ2
  get '/post_help2' => 'help#post_help2', as: :post_help2

  #ポストヘルプ3
  get '/post_help3' => 'help#post_help3', as: :post_help3

  #ポストヘルプ4
  get '/post_help4' => 'help#post_help4', as: :post_help4

  #ポストヘルプ5
  get '/post_help5' => 'help#post_help5', as: :post_help5

  #ポストヘルプ6
  get '/post_help6' => 'help#post_help6', as: :post_help6

end
