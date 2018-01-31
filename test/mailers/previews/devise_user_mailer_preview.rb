class DeviseUserMailerPreview < ActionMailer::Preview
	def reset_password_instructions
		DeviseMailer.reset_password_instructions(user, "faketoken")
	end

	def unlock_instructions
		DeviseMailer.unlock_instructions(user, "faketoken")
	end

	def email_changed
		DeviseMailer.email_changed(user)
	end

	def password_change
		DeviseMailer.password_change(user)
	end

	def invitation_instructions
		DeviseMailer.invitation_instructions(user, "faketoken")
	end

	private
	def user
		user = User.new email: 'email@test.com', name: 'Name', surname: 'Surname', second_surname: 'SecondSurname'
		inviter = User.new email: 'inviter@test.com', name: 'Inviter', surname: 'Surname', second_surname: 'SecondSurname'
		user.invited_by = inviter
		user.invitation_sent_at = Time.now
		user
	end
end
