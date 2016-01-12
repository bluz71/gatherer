Rails.application.routes.draw do
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
