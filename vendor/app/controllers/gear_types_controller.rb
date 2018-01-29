class GearTypesController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		@gear_types = @gear_types.page(params[:page])
	end

	def show
	end

	def new
	end

	def edit
	end

	def create
		if @gear_type.save gear_type_params
			flash_message @gear_type, :create, :notice
			redirect_to @gear_type
		else
			render :new
		end
	end

	def update
		if @gear_type.update gear_type_params
			flash_message @gear_type, :update, :notice
			redirect_to @gear_type
		else
			render :edit
		end
	end

	def destroy
		@gear_type.destroy
		if @gear_type.destroyed?
			flash_message @gear_type, :destroy, :notice
			redirect_to gear_types_url
		else
			flash_message @gear_type, :destroy, :error
			redirect_to @gear_type
		end
	end

	private
	def gear_type_params
		params.require(:gear_type).permit(:name)
	end
end
