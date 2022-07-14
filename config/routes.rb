Rails.application.routes.draw do
  # users
  devise_for :users, skip: 'sessions', controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  devise_scope :user do
    get	'/users/sign_in', to: 'users/sessions#new', as: :new_user_session
    post	'/users/sign_in', to: 'users/sessions#create', as: :user_session
    get	'/users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end
  get '/users/:id/profile', to: 'users#show_profile', as: :user_profile

  # books
  get '/search', to: 'books#search', as: :books_search
  get '/show_detail', to: 'books#show', as: :book_show
  post '/users/:id/add_item', to: 'books#add_item', as: :book_add_item

  # root
  root 'books#index'
end
