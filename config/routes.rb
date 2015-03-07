Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users
  ActiveAdmin.routes(self)

  root 'welcome#index'
  resources :users, only: [:show] do
    resources :invests,           only: [:index, :show]
    resources :funds,             only: [:index, :show]
    resources :leverages,         only: [:index, :show]
    resources :following_topics,  only: [:index, :show]
    get   :edit_real_name,    on: :member
    post  :update_real_name,  on: :member
  end
end
