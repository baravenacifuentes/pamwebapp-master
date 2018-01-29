class ApplicationController < ActionController::Base
	include FlashHelper

	protect_from_forgery with: :exception

	check_authorization unless: :devise_controller?

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to root_path, alert: exception.message
	end
end