Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users
  ActiveAdmin.routes(self)

  root 'welcome#index'
  
  resources :users, only: [:show] do
    scope module: 'profile' do
      resources :invests,           only: [:index, :show]
      resources :funds,             only: [:index, :show]
      resources :leverages,         only: [:index, :show]
      resources :following_topics,  only: [:index, :show]
    end
    get   :edit_real_name,    on: :member
    post  :update_real_name,  on: :member

    shallow do
      resources :funds do
        resources :invests
      end
    end
  end

  resources :funds,     only: [:index, :new, :create, :edit, :update]
  resources :leverages,  only: [:show, :new, :create, :edit, :update]
  resources :topics,    only: [:show]
end