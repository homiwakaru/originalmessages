Rails.application.routes.draw do

  root to:'toppages#index'
  get 'signup', to: 'users#new'
   
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
   get 'signup', to: 'users#new'
  
  
  resources :users, only: [:new, :create] do
    collection do
      get 'mypage'
    end
  end
  resources :users, only: [:index, :show, :new, :create]
  resources :messages, only: [:index, :create,:new, :edit, :update, :destroy]
end

