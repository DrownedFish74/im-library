Rails.application.routes.draw do
  resources :entrance
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index,:new, :create, :show] do
    resources :books do
      resources :impressions
    end
    resources :wishes
    resources :bookshelves
    resources :friends
    resources :book_searches
    resources :bookmove, only:[:index, :create]
  end
  resources :wishes, only: :show
  resources :bookshelves, only: :show
  root to: "entrance#index"
  
end
