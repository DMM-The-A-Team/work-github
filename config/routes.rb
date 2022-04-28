Rails.application.routes.draw do

  # 顧客用
# URL /customers/sign_in ...
devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, controllers: {
  sessions: "admin/sessions"
}



  root to: "public/homes#top"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "about"=>"public/homes#about"
  get "orders"=>"public/orders#index"
  get "orders/new"=>"public/orders#new"
  post "orders/confirm"=>"public/orders#confirm"
  post "orders/create"=>"public/orders#create"
  get "admin"=>"admin/homes#top"
  get "orders/complete"=>"public/orders#complete"
  get "admin/orders/:id"=>"admin/orders#show"
  patch "orders/:id"=>"admin/orders#update"
  get "orders/:id"=>"public/orders#show"

  get "items"=>"public/items#index"
  get "admin/items/new"=>"admin/items#new"
  post 'items'=>'admin/items#create'
  get 'admin/items'=>'admin/items#index'
  get 'admin/items/:id/edit'=>'admin/items#edit',as: 'edit_admins_items'
  get 'admin/items/:id'=>'admin/items#show'
  patch 'items/:id'=>'admin/items#update',as: 'update_admins_items'


  get "customers/my_page" => "public/customers#show"
  get "customers/edit_page" => "public/customers#edit"
  get "admin/customers/index" => "admin/customers#index"

  get "admin/customers/:id/edit" => "admin/customers#edit"
  get "admin/customers/:id" => "admin/customers#show"
  patch "customers/update" => "public/customers#update"
  patch "customers/:id" => "admin/customers#update"
  get "admin/customers/edit" => "admin/customers#edit"
  get "admin/customers/show" => "admin/customers#show"


  get "items/:id" => 'public/items#show'

  get 'cart_items'=>'public/cart_items#index'
  patch 'cart_items/:id'=>'public/cart_items#update', as: 'cart_item_update'
  delete 'cart_items/:id'=>'public/cart_items#destroy', as: 'cart_item_delete'
  delete 'cart_items/destroy_all'=>'public/cart_items#destroy_all',as: 'cart_item_destroy_all'
  post 'cart_items'=>'public/cart_items#create'

end
