class VariablesController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		@variables = @variables.page(params[:page])
	end

	def show
	end

	def new
	end

	def edit
	end

	def create
		if @variable.save variable_params
			flash_message @variable, :create, :notice
			redirect_to @variable
		else
			render :new
		end
	end

	def update
		if @variable.update variable_params
			flash_message @variable, :update, :notice
			redirect_to @variable
		else
			render :edit
		end
	end

	def destroy
		@variable.destroy
		if @variable.destroyed?
			flash_message @variable, :destroy, :notice
			redirect_to variables_url
		else
			flash_message @variable, :destroy, :error
			redirect_to @variable
		end
	end

	private
	def variable_params
		params.require(:variable).permit(:name)
	end
end
