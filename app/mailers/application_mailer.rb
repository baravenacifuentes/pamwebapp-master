class ApplicationMailer < ActionMailer::Base
	layout 'mailer'
	default from: 'no-reply@pamwebapp.com'
end
