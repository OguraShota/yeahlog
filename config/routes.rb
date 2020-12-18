Rails.application.routes.draw do
  get 'users/new'
  get 'users/show'
  get 'users/index'
  root 'static_pages#home'
  get :about,         to: 'static_pages#about'
  get :use_of_terms,  to: 'static_pages#terms'

  get :signup,        to: 'users#new'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
