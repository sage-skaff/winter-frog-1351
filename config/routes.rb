Rails.application.routes.draw do
  resources :plots, only: [:index]

  resources :plant_plots, only: [:destroy]
end
