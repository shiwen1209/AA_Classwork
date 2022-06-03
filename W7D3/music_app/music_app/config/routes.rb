Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :index, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :bands
  resources :albums, except: [:new, :index]
  resources :bands, only: [] do 
    resources :albums, only: [:new]
  end
end
