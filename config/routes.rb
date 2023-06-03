Rails.application.routes.draw do

 
 
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about', as: 'about'
  
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
   devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
   namespace :admin do
    resources :items
  end
  
   #顧客
   get 'customers/my_page' => 'public/customers#show', as: 'my_page'
   get 'customers/information/edit' => 'public/customers#edit'
   patch 'customers/information' => 'public/customers#update'
   get 'customers/quit' => 'public/customers#quit'
   patch 'customers/withdraw' => 'public/customers#withdraw'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
