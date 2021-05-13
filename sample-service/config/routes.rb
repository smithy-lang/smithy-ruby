Rails.application.routes.draw do
  resources :high_scores
  post 'stream', controller: 'high_scores', action: :stream
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
