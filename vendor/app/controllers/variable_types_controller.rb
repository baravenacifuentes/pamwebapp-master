class VariableTypesController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		@variable_types = @variable_types.page(params[:page])
	end

	def show
	end

	def new
	end

	def edit
	end

	def create
		if @variable_type.save variable_type_params
			flash_message @variable_type, :create, :notice
			redirect_to @variable_type
		else
			render :new
		end
	end

	def update
		if @variable_type.update variable_type_params
			flash_message @variable_type, :update, :notice
			redirect_to @variable_type
		else
			render :edit
		end
	end

	def destroy
		@variable_type.destroy
		if @variable_type.destroyed?
			flash_message @variable_type, :destroy, :notice
			redirect_to variable_types_url
		else
			flash_message @variable_type, :destroy, :error
			redirect_to @variable_type
		end
	end

	private
	def variable_type_params
		params.require(:variable_type).permit(:name)
	end
end
