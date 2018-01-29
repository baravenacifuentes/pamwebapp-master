Rails.application.routes.draw do
	# Devise users
	devise_for :users, path: '', skip: :registrations, controllers: { invitations: 'invitations' }
	devise_scope :user do
		get 'edit', to: 'devise/registrations#edit', as: 'edit_user_registration'
		patch '', to: 'devise/registrations#update', as: 'user_registration'
		put '', to: 'devise/registrations#update'
	end
	resources :users, only: [:index, :show, :destroy]

	resources :gear_types
	resources :gears
	resources :components
	resources :units
	resources :samples
	resources :lubricants
	resources :variable_types

	root to: 'home#index'
end
