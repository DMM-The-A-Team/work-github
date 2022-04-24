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



  root to: "homes#top"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/about"=>"homes#about"
  get "/orders"=>"orders#index"
  get "orders/new"=>"orders#new"

  get "items"=>"public/items#index"
  get "admin/items/new"=>"admin/items#new"
  post 'items'=>'admin/items#create'
  get 'admin/items'=>'admin/items#index'


  get "customers/my_page" => "public/customers#show"
  get "customers/edit_page" => "public/customers#edit"
  get "admin/customers/index" => "admin/customers#index"
  get "admin/customers/edit" => "admin/customers#edit"
  get "admin/customers/show" => "admin/customers#show"

  get "items/:id" => 'public/items#show'


end
