VoteOScope::Application.routes.draw do
  devise_for :users
  resources :questions do
    get :answer, on: :collection
  end
  resources :answers
  resources :parties
  resources :landing, only: [:index]
  root 'questions#answer'
end
