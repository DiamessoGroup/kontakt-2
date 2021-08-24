# frozen_string_literal: true

Rails.application.routes.draw do
  resources :usertests
  devise_for :users

  root 'app#home'
  get 'admin', to: 'app#admin'
  # Rails.application.routes.draw do
  #   devise_for :users, controllers: {
  #     sessions: 'users/sessions'
  #   }
  # end
  get 'admin/profile', to: 'admin#profile'
  get 'admin/create_contact', to: 'admin#create_contact'
  get 'admin/contact_list', to: 'admin#contact_list'

  resources :users do
    resources :profiles, only: %i[new create edit update]
    resources :notes
    resources :contacts
  end

  get 'contacts/search', to: 'contacts#search'

  get 'admin/onboarding', to: 'profiles#onboarding'
  post 'admin/onboarding', to: 'profiles#create_onboarding'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
