Rails.application.routes.draw do

  #devise_for :controllers
  devise_for :users
   root 'welcome#index'
end
