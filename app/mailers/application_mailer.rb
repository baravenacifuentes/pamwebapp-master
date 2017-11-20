class ApplicationMailer < ActionMailer::Base
	layout 'mailer'
	# TODO change mail
	default from: 'no-reply@pmbokprojects.com'
end
