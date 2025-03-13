# frozen_string_literal: true

Rails.application.routes.draw do
  # BEGIN
  scope '/(:locale)', locale: /en|ru/ do
    root 'home#index'
    resources :posts do
      resources :comments, exclude: :index, controller: 'posts/comments'
    end
  end
  # END

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
