Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { registrations: 'registrations'}
  ActiveAdmin.routes(self)
  mount ChinaCity::Engine => '/china_city'
  root 'welcome#index'
  
  resources :users, only: [:show] do
    scope module: 'profile' do
      resources :invests,           only: [:index, :show]
      resources :funds,             only: [:index, :show]
      resources :leverages,         only: [:index, :show]
      resources :following_topics,  only: [:index, :show]
    end
    get   :investor_apply,    on: :member
    get   :trader_apply,    on: :member
    patch :applied,  on: :member
  end

  resources :funds do
    resources :invests
  end
  resources :leverages, only: [:show, :new, :create, :edit, :update]
  resources :topics,    only: [:show, :index]
  resources :news,      only: [:show, :index]
end