Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'main#index'

  match 'about', to: 'main#about', via: :get

  get 'tasks/index'
  get 'tasks/new'
  get 'tasks/edit'
end
