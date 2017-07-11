Rails.application.routes.draw do

  devise_for :users

  resources :events
  resource :user
  #这里的路由设计使用单数 resource :user，跟 resources :users 相比，单数的路由少了 index action
  namespace :admin do
    root "events#index"
    resources :events do
      resources :tickets, :controller => "event_tickets"
      collection do
        post :bulk_update
      end
      member do
        post :reorder
      end
    end
    resources :users do
      resource :profile, :controller => "user_profiles"
      #因为默认的 controller 的命名是 profiles，这里我们偏好自定义命名改为 user_prorfiles
    end
  end


  root "events#index"
  get "/faq" => "pages#faq"

end
