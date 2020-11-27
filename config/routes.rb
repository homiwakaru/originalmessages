Rails.application.routes.draw do

  root to:'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  
  resources :users, only: [:new, :create] do
    collection do
      get 'mypage'
    end
  end
  resources :users
  resources :messages, only: [:index, :creste,:new, :edit, :update, :destroy]
end

