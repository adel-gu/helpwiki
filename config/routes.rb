Rails.application.routes.draw do
  devise_for :users

  root "landing#index"

  scope "/:subdomain" do
    namespace :app do
      root "home#index"

      resources :users_management, only: %i[ index update destroy ]
    end
  end

  resource :workspace, only: %i[new create]
end
