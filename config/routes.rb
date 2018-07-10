Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'sessions#index', as: 'root'
  get '/login', to: 'sessions#new', as:'login'
  post '/', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new', as:'signup'
  post '/signup', to: 'users#create'


  resources :users do
    resources :children
    resources :availabilities
    resources :session_bookings
  end

  resources :schools do
    get '/users/:user_id', to: 'users#user_availabilities'
    get '/users/:user_id/bookings', to: 'users#user_bookings'
  end
end
