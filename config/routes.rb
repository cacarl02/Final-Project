Rails.application.routes.draw do
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
  resources :trips
  resources :bookings
  resources :users
  resources :admin, only: [:index, :show] do
    member do
      patch :verify_user
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
