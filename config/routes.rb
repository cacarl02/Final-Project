Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'
  devise_for :users,
             defaults: { format: :json },
             path: '',
             path_names: {
               sign_in: '/login',
               sign_out: '/logout',
               registration: '/signup'
             },
             controllers: {
              sessions: 'users/sessions',
              registrations: 'users/registrations'
              # confirmations: 'users/confirmations'
            }
  resources :trips do
    get 'bookings_on_trip', on: :member, controller: 'bookings'
    member do
      get :history
    end
    collection do
      get :pending_trips
    end
  end
  resources :bookings do
    member do
      get :history
    end
  end
  resources :users do
    member do
      patch :topup_balance
    end
  end
  resources :admin, only: [:index, :show] do
    member do
      patch :verify_user
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
