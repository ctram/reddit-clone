Rails.application.routes.draw do
  root 'sessions#new'
  resources :users, except: [:edit, :update]
  resource :session, only: [:new, :create, :destroy]
end
