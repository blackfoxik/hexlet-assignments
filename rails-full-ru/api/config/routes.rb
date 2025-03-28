# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'

    resources :users
  end

  namespace :api do
    resources :users, only: %i[index show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end