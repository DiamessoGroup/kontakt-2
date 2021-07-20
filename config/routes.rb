Rails.application.routes.draw do
  resources :usertests
  #devise_for :users
  root 'app#home'
  get 'app/about'
  get 'admin', to: 'app#admin'
  Rails.application.routes.draw do
    devise_for :users, controllers: {
      sessions: 'users/sessions'
    }
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
