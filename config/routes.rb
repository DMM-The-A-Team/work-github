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

  get "home/about"=>"homes#about"

  get "items"=>"public/items#index"


  get "customers/my_page" => "public/customers#show"

  get "customers/edit_page" => "public/customers#edit"


  get "items/:id" => 'public/items#show'

end
