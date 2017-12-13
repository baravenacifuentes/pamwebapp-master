class HomeController < ApplicationController
	before_action :authenticate_user!

	def index
		@gear_types = GearType.includes(gears: [:worst_sample, components: [units: [:samples, worst_sample: [:lubricant]]]])
	end
end
