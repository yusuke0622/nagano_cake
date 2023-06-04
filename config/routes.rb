Rails.application.routes.draw do

 
 
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about', as: 'about'
  
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
   devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
 
  
   #顧客情報
   get 'customers/my_page' => 'public/customers#show', as: 'my_page'
   get 'customers/information/edit' => 'public/customers#edit'
   patch 'customers/information' => 'public/customers#update'
   get 'customers/quit' => 'public/customers#quit'
   patch 'customers/withdraw' => 'public/customers#withdraw'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  #管理者　商品
   namespace :admin do
    resources :items
  end
  
  #顧客　商品
   scope module: :public do
    resources :items, only: [:index, :show]
   end
   
  #管理者　顧客管理
   namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
   end
end
