Rails.application.routes.draw do
  devise_for :users
  root 'app#home'
  get 'app/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
