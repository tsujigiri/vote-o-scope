VoteOScope::Application.routes.draw do
  devise_for :users
  resources :questions
  resources :answers
  resources :parties
  resources :landing, only: [:index]
  root 'landing#index'
end
