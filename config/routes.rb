Rails.application.routes.draw do
  resources :members, :only => [:index, :new, :create, :show]
  resources :examples
  get 'user/new'
  get 'user/create'
  devise_for :auths
  get 'dashboard/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'dashboard#index'
end
