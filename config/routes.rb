VoteOScope::Application.routes.draw do
  devise_for :users
  get :dashboard, to: 'users#dashboard', as: :user_root
  resources :questions do
    get :answer, on: :collection
  end
  resources :answers do
    put :update, on: :collection
  end
  resources :parties
  resources :landing, only: [:index]
  root 'questions#answer'
end
