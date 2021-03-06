Rails.application.routes.draw do

  devise_for :users

  resources :events do
    resources :registrations do
      member do
        get "steps/1" => "registrations#step1", :as => :step1
        patch "steps/1/update" => "registrations#step1_update", :as => :update_step1
        get "steps/2" => "registrations#step2", :as => :step2
        patch "steps/2/update" => "registrations#step2_update", :as => :update_step2
        get "steps/3" => "registrations#step3", :as => :step3
        patch "steps/3/update" => "registrations#step3_update", :as => :update_step3
      end
    end
  end
  resource :user
  #这里的路由设计使用单数 resource :user，跟 resources :users 相比，单数的路由少了 index action
  namespace :admin do
    root "events#index"
    resources :events do
      resources :registrations, :controller => "event_registrations"
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
