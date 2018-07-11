Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #homepage
  get '/', to: 'sessions#index', as: 'root'
  #login form
  get '/login', to: 'sessions#new', as:'login'
  #adds user_id to the session
  post '/', to: 'sessions#create'
  #removes user_id from the session
  get '/logout', to: 'sessions#destroy'
  #form to create a new user
  get '/signup', to: 'users#new', as:'signup'
  #generates new user and adds to the database
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
