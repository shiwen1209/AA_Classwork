Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static_pages#root'

  namespace :api, defaults: {format: :json}  do
    resources :users, only: [ :create]
    resources :benches, only: [ :index, :create] # if use singular resource, index route does not show
    resource :session, only: [ :create, :destroy ]
  end


end
