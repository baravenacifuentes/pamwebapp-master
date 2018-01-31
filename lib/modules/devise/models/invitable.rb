module Devise
	module Models
		module Invitable
			# Prevent password changed email when accepting invitation
			def send_password_change_notification
				super unless accepting_invitation?
			end

			def send_reset_password_instructions
				if invited_to_sign_up?
					self.errors.add :email, :invitation_active
				else
					token = set_reset_password_token
					send_reset_password_instructions_notification(token)

					token
				end
			end
		end
	end
end
