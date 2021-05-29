# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :users do
    get 'sessions/new'
    get 'sessions/destroy'
  end
  root to: 'users/dashboards#show'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end

  namespace :api do
    namespace :v1 do
      resources :transactions, only: %i[create index]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
