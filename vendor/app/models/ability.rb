class Ability
	include CanCan::Ability

	def initialize(user)
		alias_action :create, :read, :update, to: :cru

		can :visualize, :dashboard
		can :update, User, id: user.id
		can :show, Unit

		if user.is_analyst?
			can :cru, Sample
		end

		if user.is_admin?

			can :read, User
			can :create, User
			can :destroy, User do |user|
				not user.is_admin?
			end

			can :cru, Sample
			can :cru, GearType
			can :cru, Gear
			can :cru, Component
			can :cru, Unit
			can :cru, Lubricant

			can :destroy, GearType, has_children?: false
			can :destroy, Gear, has_children?: false
			can :destroy, Component, has_children?: false
			can :destroy, Unit, has_children?: false
			can :destroy, Lubricant, has_units?: false, has_samples?: false
		end
	end
end
