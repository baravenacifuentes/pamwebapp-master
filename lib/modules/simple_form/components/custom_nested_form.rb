module SimpleForm
	module Components
		# Needs to be enabled in order to do automatic lookups
		module CustomNestedForm
			# Name of the component method
			def remove_link(wrapper_options = nil)
				@remove_link ||= begin
					options[:remove_link].to_s.html_safe if options[:remove_link].present?
				end
			end

			# Used when the at is optional
			def has_remove_link?
				remove_link.present?
			end
		end
	end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::CustomNestedForm)
