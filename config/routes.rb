Rails.application.routes.draw do
  # get 'games_controller/new'
  # get 'games_controller/score'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'new', to: 'games#new', as: :new
  post 'score', to: 'games#score', as: :score
end
