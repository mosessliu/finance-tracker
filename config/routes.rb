Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'users/registrations'} 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'my_friends', to: 'users#my_friends'

  get 'search_friends_query', to: 'friends#search_query'
  get 'search_friends_results', to: 'friends#search_results'

  get 'search_stocks', to: 'stocks#search'
  
  resources :user_stocks, only: [:create, :destroy]
  resources :friends, only: [:create, :destroy]
  resources :users, only: [:show]

  get 'my_portfolio/change_display_style', to: 'user_stocks#change_portfolio_display_style'

end
