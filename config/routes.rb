Rails.application.routes.draw do
  resources :plots, only: [:index]
  resources :gardens, only: [:show]
  resources :plant_plots, only: [:destroy]
end
