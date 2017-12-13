class Ability
	include CanCan::Ability

	def initialize(user)
		can :update, User, id: user.id
		can :read, Unit

		if user.is_admin?
			# can :read, User
			# can :create, User
			# can :destroy, User do |user|
				# not user.is_admin?
			# end
		end
	end
end
