Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { registrations: 'registrations'}
  ActiveAdmin.routes(self)
  mount ChinaCity::Engine => '/china_city'
  root 'welcome#index'

  resources :welcome do
    get :funds, on: :collection
  end
  resources :users, only: [:show] do
    get :get_history_data, on: :member
    get :show_history_data, on: :member
    resource :bank_card
    resource :account do
      resources :billings
      get   :bankcard_charge,   on: :member
      get   :alipay_charge,     on: :member
      get   :third_charge,      on: :member
      post  :bankcard_charged,  on: :member
      post  :alipay_charged,    on: :member
      post  :third_charged,     on: :member
    end
    scope module: 'profile' do
      resources :invests,           only: [:index, :show]
      resources :funds,             only: [:index, :show]
      resources :leverages,         only: [:index, :show]
      resources :following_topics,  only: [:index, :show]
    end
    get   :generate_verification_code,  on: :collection
    post  :save_avatar,       on: :member
    post  :update_password,     on: :collection
    get   :investor_apply,    on: :member
    get   :trader_apply,      on: :member
    patch :investor_applied,  on: :member
    patch :trader_applied,    on: :member
    get   :get_chart_data,    on: :member
    resource :cash_management
    get   :cashin,            on: :member
    get   :cashout,            on: :member
  end

  resources :billings do
    get :realtime_trade, on: :member
    get :order_result_query, on: :member
  end

  resources :funds do
    resources :invests do
      post :unlock, on: :collection
    end
  end
  resources :leverages, only: [:show, :new, :create, :edit, :update] do
    post :query_rate, on: :collection
  end
  resources :topics,    only: [:show, :index]
  resources :news,      only: [:show, :index]
end
