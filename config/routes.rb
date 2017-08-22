Rails.application.routes.draw do

  get 'collaborators/new'

  get 'collaborators/create'

  get 'collaborators/destroy'

  get 'downgrade/new'

  get 'charges/new'

  
  
  #resources :users, only: [:new, :create, :show]

  resources :charges, only: [:new, :create]


  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  get 'about' => 'welcome#about'
  
  #MarkdownExample::Application.routes.draw do
  get 'collaborators/new'

  get 'collaborators/create'

  get 'collaborators/destroy'

  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end
  root 'welcome#index'
  #end
end
