Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  resources :projects

  devise_for :users
  root "projects#index"

  resources :tasks do
    member do
      patch :up
      patch :down
    end
  end

end
