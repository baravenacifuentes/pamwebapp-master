module Devise
	module Models
		module Confirmable
			def send_reconfirmation_instructions
				@reconfirmation_required = false

				unless @skip_confirmation_notification
					unless @raw_confirmation_token
						generate_confirmation_token!
					end

					opts = pending_reconfirmation? ? { to: unconfirmed_email } : { }
					send_devise_notification(:reconfirmation_instructions, @raw_confirmation_token, opts)
				end
			end
		end
	end
end
