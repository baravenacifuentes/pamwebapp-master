class LubricantsController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		@lubricants = @lubricants.page(params[:page])
	end

	def show
	end

	def new
	end

	def edit
	end

	def create
		if @lubricant.save lubricant_params
			flash_message @lubricant, :create, :notice
			redirect_to @lubricant
		else
			render :new
		end
	end

	def update
		if @lubricant.update lubricant_params
			flash_message @lubricant, :update, :notice
			redirect_to @lubricant
		else
			render :edit
		end
	end

	def destroy
		@lubricant.destroy
		if @lubricant.destroyed?
			flash_message @lubricant, :destroy, :notice
			redirect_to lubricants_url
		else
			flash_message @lubricant, :destroy, :error
			redirect_to @lubricant
		end
	end

	private
	def lubricant_params
		params.require(:lubricant).permit(:name, :max_hours, variables_attributes: [:id, :type_id, :min, :mid, :max, :_destroy])
	end
end
