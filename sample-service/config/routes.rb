Rails.application.routes.draw do
  resources :high_scores
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'basic_auth', to: 'auth#basic_auth'
  get 'digest_auth', to: 'auth#digest_auth'
  get 'bearer_auth', to: 'auth#bearer_auth'
  get 'api_key_auth', to: 'auth#api_key_auth'
end
