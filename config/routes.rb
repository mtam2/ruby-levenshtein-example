Rails.application.routes.draw do
  root to: 'users#index'
  resources :users, only: [:index]
  get 'users/email_character_frequency', to: 'users#email_character_frequency'
  get 'users/possible_duplicate_emails', to: 'users#possible_duplicate_emails'
  post 'users/refresh_data', to: 'users#refresh_data'
  match '*unmatched_route', to: 'users#index', via: :all
end
