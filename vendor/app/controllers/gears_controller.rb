class GearsController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		@gears = @gears.page(params[:page])
	end

	def show
	end

	def new
	end

	def edit
	end

	def create
		if @gear.save gear_params
			flash_message @gear, :create, :notice
			redirect_to @gear
		else
			render :new
		end
	end

	def update
		if @gear.update gear_params
			flash_message @gear, :update, :notice
			redirect_to @gear
		else
			render :edit
		end
	end

	def destroy
		@gear.destroy
		if @gear.destroyed?
			flash_message @gear, :destroy, :notice
			redirect_to gears_url
		else
			flash_message @gear, :destroy, :error
			redirect_to @gear
		end
	end

	private
	def gear_params
		params.require(:gear).permit(:name, :type_id)
	end
end
