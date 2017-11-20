class CustomDeviseController < ApplicationController
	before_action :configure_permitted_parameters

	protected
	def after_sign_in_path_for(resource)
		stored_location_for(resource) || root_path
	end

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:invite, keys: [:name, :surname, :second_surname])
		devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name, :surname, :second_surname])
		devise_parameter_sanitizer.permit(:account_update, keys: [:name, :surname, :second_surname, :remember_me])
	end
end
