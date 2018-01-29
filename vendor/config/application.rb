require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pam
	class Application < Rails::Application
		# Settings in config/environments/* take precedence over those specified here.
		# Application configuration should go into files in config/initializers
		# -- all .rb files in that directory are automatically loaded.
		config.time_zone = 'Santiago'

		# The default locale is :es and all translations from config/locales/*.rb,yml are auto loaded.
		config.i18n.load_path += Dir[Rails.root.join('app', 'locales', '**', '*.{rb,yml}')]
		config.i18n.default_locale = :es
		config.i18n.available_locales = [:es]

		config.eager_load_paths << "#{Rails.root}/lib"
		config.autoload_paths += Dir[Rails.root.join('app', 'models', "{*/}")]
	end
end
