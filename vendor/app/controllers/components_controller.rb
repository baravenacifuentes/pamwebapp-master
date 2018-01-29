class ComponentsController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		@components = @components.page(params[:page])
	end

	def show
	end

	def new
	end

	def edit
	end

	def create
		if @component.save component_params
			flash_message @component, :create, :notice
			redirect_to @component
		else
			render :new
		end
	end

	def update
		if @component.update component_params
			flash_message @component, :update, :notice
			redirect_to @component
		else
			render :edit
		end
	end

	def destroy
		@component.destroy
		if @component.destroyed?
			flash_message @component, :destroy, :notice
			redirect_to components_url
		else
			flash_message @component, :destroy, :error
			redirect_to @component
		end
	end

	private
	def component_params
		params.require(:component).permit(:name, :gear_id)
	end
end
