Rails.application.routes.draw do
  resources :logs
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'log_parser#index'

  # get 'log_parser/index'
end
