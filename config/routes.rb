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
  get "orders/confirm"=>"public/orders#confirm"
  get "admin"=>"admin/homes#top"

  get "items"=>"public/items#index"
  get "admin/items/new"=>"admin/items#new"
  post 'items'=>'admin/items#create'
  get 'admin/items'=>'admin/items#index'
  get 'admin/items/:id/edit'=>'admin/items#edit'
  get 'admin/items/:id'=>'admin/items#show'
  patch 'items/:id'=>'admin/items#update'


  get "customers/my_page" => "public/customers#show"
  get "customers/edit_page" => "public/customers#edit"
  get "admin/customers/index" => "admin/customers#index"
  get "admin/customers/edit" => "admin/customers#edit"
  get "admin/customers/show" => "admin/customers#show"

  get "items/:id" => 'public/items#show'


end
