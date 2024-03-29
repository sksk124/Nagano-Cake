Rails.application.routes.draw do

devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

get '/', to: 'public/homes#top', as: 'top'
get '/about', to: 'public/homes#about'
get '/admin', to: 'admin/homes#top', as: 'home'
get '/customers/my_page', to: 'public/customers#show'
get '/customers/information/edit', to: 'public/customers#edit'
patch '/customers/my_page', to: 'public/customers#update'
get '/customers/unsubscribe', to: 'public/customers#unsubscribe'
patch 'customers/unsubscribe' => 'public/customers#withdraw', as: :customers_withdraw


namespace :admin do
    resources :items
    resources :customers
    resources :genres
    resources :orders
    resources :order_details
  end


 scope module: :public do
  resources :customers, only: [:show, :edit, :update]
  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  delete '/cart_items/delete_all', to: 'cart_items#destroy_all', as: 'delete_all_cart_items'
  resources :cart_items
  resources :orders  do
   post 'confirm', on: :collection
   get 'complete', on: :collection
   delete 'destroy_all', on: :collection
  end
  resources :addresses
 end

end
