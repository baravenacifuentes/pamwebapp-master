Rails.application.routes.draw do
  resources :variables
	# Devise users
	devise_for :users, path: '', skip: :registrations, controllers: { invitations: 'invitations' }
	devise_scope :user do
		get 'edit', to: 'devise/registrations#edit', as: 'edit_user_registration'
		patch '', to: 'devise/registrations#update', as: 'user_registration'
		put '', to: 'devise/registrations#update'
	end

	resources :gear_types
	resources :gears
	resources :components
	resources :units
	resources :samples
	resources :lubricants
	resources :variables
	resources :sample_variables

	root to: 'home#index'
end
