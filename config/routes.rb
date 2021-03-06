Rails.application.routes.draw do
  root to: 'cocktails#index'
  resources :cocktails, only: %i[new create index show update] do
    resources :doses, only: %i[new create]
  end
  resources :doses, only: [:destroy]
end
