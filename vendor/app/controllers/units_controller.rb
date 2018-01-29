class UnitsController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		@units = @units.page(params[:page])
	end

	def show
	end

	def new
	end

	def edit
	end

	def create
		if @unit.save unit_params
			flash_message @unit, :create, :notice
			redirect_to @unit
		else
			render :new
		end
	end

	def update
		if @unit.update unit_params
			flash_message @unit, :update, :notice
			redirect_to @unit
		else
			render :edit
		end
	end

	def destroy
		@unit.destroy
		if @unit.destroyed?
			flash_message @unit, :destroy, :notice
			redirect_to units_url
		else
			flash_message @unit, :destroy, :error
			redirect_to @unit
		end
	end

	private
	def unit_params
		params.require(:unit).permit(:name, :component_id, :lubricant_id)
	end
end
