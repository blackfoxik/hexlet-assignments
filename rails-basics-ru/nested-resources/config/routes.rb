# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts/posts#index'
  scope module: :posts do
    resources :posts do
      resources :comments, except: [:index]
    end
  end

  # BEGIN

  # END
end
