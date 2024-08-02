Rails.application.routes.draw do
  resources :carts
  resources :collections
  resources :subscriptions
  resources :customers
  resources :sessions
  
  resources :home do
    collection do
      get :new_item
    end
  end

  root 'home#home'
  
  get 'saved', action: :index, controller: 'savedlist'
  
  get 'customers/new'
  
  get '/signup', to: 'customers#new'
  post '/signup', to: 'customers#create'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  get '/subscribe', to: 'subscriptions#new'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
