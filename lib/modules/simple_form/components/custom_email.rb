module SimpleForm
	module Components
		# Needs to be enabled in order to do automatic lookups
		module CustomEmail
			# Name of the component method
			def at(wrapper_options = nil)
				@at ||= begin
					options[:at].to_s.html_safe if options[:at].present?
				end
			end

			# Used when the at is optional
			def has_at?
				at.present?
			end
		end
	end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::CustomEmail)
