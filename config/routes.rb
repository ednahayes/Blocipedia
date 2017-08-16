Rails.application.routes.draw do

  get 'downgrade/new'

  get 'charges/new'

  resources :wikis
  
  #resources :users #[:new, :create, :show]
  
  resources :charges, only: [:new, :create]

  #devise_for :controllers
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  get 'about' => 'welcome#about'
  root 'welcome#index'
end
