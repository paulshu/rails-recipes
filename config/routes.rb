Rails.application.routes.draw do

  devise_for :users

  resources :events
  resource :user
  #这里的路由设计使用单数 resource :user，跟 resources :users 相比，单数的路由少了 index action
  namespace :admin do
    root "events#index"
    resources :events
    resources :users
  end

  root "events#index"
  get "/faq" => "pages#faq"

end
