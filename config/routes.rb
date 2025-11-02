Rails.application.routes.draw do
  devise_for :users

  root "landing#index"

  namespace :app do
    root "home#index"
  end
end
