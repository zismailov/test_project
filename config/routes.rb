Rails.application.routes.draw do
  resources :foos do
    resources :bars
  end

  root "foos#index"
end