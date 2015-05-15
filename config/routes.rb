Rails.application.routes.draw do
  root 'sessions#new'
  resources :users, except: [:edit, :update]
  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: :destroy do
    resources :posts, only: [:edit, :new]
  end
  resources :posts, except: [:destroy, :index, :edit, :new]

end
