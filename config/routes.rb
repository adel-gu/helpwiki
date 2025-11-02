Rails.application.routes.draw do
  devise_for :users

  root "landing#index"

  scope "/:subdomain" do
    namespace :app do
      root "home#index"
    end
  end

  resource :workspace, only: %i[new create]
end
