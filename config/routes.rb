Rails.application.routes.draw do


  get 'downgrade/new'

  get 'charges/new'

  
  
  #resources :users, only: [:new, :create, :show]

  resources :charges, only: [:new, :create, :destroy]


  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  get 'about' => 'welcome#about'
  
  #MarkdownExample::Application.routes.draw do

  resources :wikis do
    resources :collaborators, only: [:index, :create, :destroy]
  end
  root 'welcome#index'
  #end
end
