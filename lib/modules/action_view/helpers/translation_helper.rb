module ActionView
	module Helpers
		module TranslationHelper
			def t(key, options = {})
				result = translate(key, options)
				if result.is_a? String
					result
					.gsub('APP_NAME_PLAIN', translate('globals.app_name_plain'))
					.gsub('APP_NAME', translate('globals.app_name'))
					.html_safe
				else
					result
				end
			end
		end
	end
end
