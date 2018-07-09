Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :children
    resources :availabilities
    resources :session_bookings
  end
  resources :schools do
    get '/users/:user_id', to: 'users#user_availabilities'
  end
end
