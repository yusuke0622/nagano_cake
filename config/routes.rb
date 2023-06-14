Rails.application.routes.draw do

 
 
 #顧客　トップページ
  root to: 'public/homes#top'
 #顧客　Aboutページ
  get 'about' => 'public/homes#about', as: 'about'
  
  #管理者　トップページ
  get 'admin' => 'admin/homes#top'
  
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
   devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
 
  
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  #管理者　商品
   namespace :admin do
    resources :items
  end


  

  scope module: :public do
   
   #顧客情報
   get   'customers/my_page'          => 'customers#show', as: 'my_page'
   get   'customers/information/edit' => 'customers#edit'
   patch 'customers/information'      => 'customers#update'
   get   'customers/quit'             => 'customers#quit'
   patch 'customers/withdraw'         => 'customers#withdraw'

   
   #顧客　カート内商品消去
   delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
   
   #顧客　注文情報確認　完了
   post 'orders/confirm' => 'orders#confirm'
   get  'orders/thanx'   => 'orders#thanx'
   
    #顧客　商品　顧客管理　カート内商品　注文
   resources :items,      only: [:index, :show]
   resources :customers,  only: [:index, :show, :edit, :update]
   resources :cart_items, only: [:index,:update, :destroy, :create]
   resources :orders,     only: [:new, :create, :index, :show]
  
  end
  
  
end
