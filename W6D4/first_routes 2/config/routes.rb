Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'users/', to: 'users#index'
  # post 'users/', to: 'users#create'
  # # get 'users/new', to: 'users#new', as: 'new_user'
  # # get 'users/:id/edit', to: 'users#edit', as: 'edit_user'
  # get 'users/:id', to: 'users#show', as: 'user'
  # patch 'users/:id', to: 'users#update'
  # # put 'users/:id', to: 'users#update'
  # delete 'users/:id', to: 'users#destroy'
  
  resources :users do 
    resources :artworks, only: :index
  end 

  resources :users do 
    resources :comments, only: :index
  end 

  resources :artworks do 
    resources :comments, only: :index
  end 

  resources :artworks do 
    member do 
      post :favorite, to: 'artworks#favorite', as: 'favorite'
      post :unfavorite, to: 'artworks#unfavorite', as: 'unfavorite'
    end
  end

  resources :artwork_shares do 
    member do 
      post :favorite, to: 'artwork_shares#favorite', as: 'favorite'
      post :unfavorite, to: 'artwork_shares#unfavorite', as: 'unfavorite'
    end
  end

  # the above default to ==> get 'users/:user_id/artworks', to: 'artworks#index'

  resources :users, only: [:index, :create, :show, :update, :destroy]
  resources :artworks, only: [:create, :show, :update, :destroy]
  resources :artwork_shares, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]


end
