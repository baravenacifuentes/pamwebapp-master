class HomeController < ApplicationController
	before_action :authenticate_user!
	def index
		@gear_types = GearType.all
	end
end
