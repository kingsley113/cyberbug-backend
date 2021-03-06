Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	root 'welcome#index'

	namespace :api do
			resources :bugs
			resources :projects

			resources :users, only: [:create]
			post '/login', to: 'auth#create'
			get '/profile', to: 'users#profile'
	end

end
