Rails.application.routes.draw do

  devise_for :users, controllers: {
		sessions: 'sessions', registrations: 'registrations' }, path: '',
		path_names: { sign_in: 'login', sign_out: 'logout'}
	
  root 'posts#index', as: 'posts_index'
  resources :posts
  resources :comments
  get 'tags/:tag', to: 'posts#index', as: :tag
	get 'all', to: 'posts#index', all: 'all'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
