class InvitationsController < Devise::InvitationsController
	load_and_authorize_resource :user, only: [:new, :create]

	private
	def after_invite_path_for(resource)
		users_path
	end
end
