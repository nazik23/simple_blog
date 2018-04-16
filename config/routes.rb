Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions' }
  devise_scope :user do 
	 get 'login', to: 'users/sessions#new'
	 post 'login', to: 'users/sessions#create'
	 delete 'logout', to: 'users/sessions#destroy'
	 get 'signup', to: 'devise/registrations#new'
	 post 'signup', to: 'devise/registrations#create'
  end
  root 'posts#index', as: 'posts_index'
  resources :posts
  resources :comments
  get 'tags/:tag', to: 'posts#index', as: :tag
	get 'all', to: 'posts#index', all: 'all'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
