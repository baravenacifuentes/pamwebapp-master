# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_pamwebapp_session', domain: {
	production: :all,
	development: :all
}.fetch(Rails.env.to_sym, :all)

