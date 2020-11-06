# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :users, only: [:show, :create, :update, :destroy, :index]
    get 'typehead/:input' => 'users#typeahead'
  end
end
