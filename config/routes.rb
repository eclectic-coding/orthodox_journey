
Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users
  get "/users/dashboard" => "users#show", as: :user_root

  authenticate :user, lambda { |u| u.admin? } do
    if defined? (Sidekiq)
      require 'sidekiq/web'
      mount Sidekiq::Web => '/sidekiq'
    end

    namespace :admin do
      root to: "dashboard#show"
      resources :users, only: %i[index show]
      resources :books, only: %i[index new]
    end
  end

  namespace :users do
    resources :books, only: %i[index]
  end

  # Defines the root path route ("/")
  root "static#home"
  resources :books, only: %i[index show]
end
