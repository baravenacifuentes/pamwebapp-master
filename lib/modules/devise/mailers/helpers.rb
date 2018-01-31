module Devise
	module Mailers
		module Helpers
			def template_paths
				template_path = _prefixes.dup
				template_path.unshift "#{@devise_mapping.scoped_path}/devise/mailer" if self.class.scoped_views?
				template_path
			end

			def subject_for(key)
				I18n.t :subject, scope: [:devise, :mailer, key], default: [:subject, key.to_s.humanize]
			end
		end
	end
end
