# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'

    resources :movies do
      scope module: :movies do
        resources :reviews, except: :show
        resources :comments, except: :show
      end
    end

    resources :reviews, only: %i[index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end