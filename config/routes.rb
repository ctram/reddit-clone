Rails.application.routes.draw do
  root 'sessions#new'
  resources :users, except: [:edit, :update]
  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: :destroy
  resources :posts, except: [:destroy, :index]
  resources :comments, only: [:new, :create]
end
