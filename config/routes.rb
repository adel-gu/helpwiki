Rails.application.routes.draw do
  devise_for :users

  root "landing#index"

  scope "/:subdomain" do
    namespace :app do
      root "home#index"

      resources :users_management, except: %i[ show edit ]

      resource :profile, only: %i[edit update] do
        member do
          get :security
          patch :update_password
          get :notifications
        end
      end
    end
  end

  resource :workspace, only: %i[new create]
end
