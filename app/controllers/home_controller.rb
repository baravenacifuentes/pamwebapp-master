class HomeController < ApplicationController
	before_action :authenticate_user!

	def index
		@gear_types = GearType.includes(gears: [:components, :worst_sample])
	end
end
