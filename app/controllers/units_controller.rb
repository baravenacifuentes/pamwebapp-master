class UnitsController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	# GET /units
	# GET /units.json
	def index
	end

	# GET /units/1
	# GET /units/1.json
	def show
	end

	# GET /units/new
	def new
	end

	# GET /units/1/edit
	def edit
	end

	# POST /units
	# POST /units.json
	def create
		respond_with @unit
	end

	# PATCH/PUT /units/1
	# PATCH/PUT /units/1.json
	def update
		respond_with @unit
	end

	# DELETE /units/1
	# DELETE /units/1.json
	def destroy
		@unit.destroy
		respond_with @unit
	end

	private
	def unit_params
		params.require(:unit).permit(:name, :component_id, :lubricant_id)
	end
end
