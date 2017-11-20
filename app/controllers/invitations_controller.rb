class InvitationsController < Devise::InvitationsController
	before_action :check_administrator, only: [:new, :create]

	private
	def check_administrator
		redirect_to root_path, alert: 'Sólo administradores pueden realizar invitaciones' unless current_user.admin?
	end
end
