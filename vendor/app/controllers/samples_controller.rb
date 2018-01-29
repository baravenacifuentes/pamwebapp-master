class SamplesController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		@samples = @samples.page(params[:page])
	end

	def show
	end

	def new
	end

	def edit
	end

	def create
		if @sample.save create_params
			flash_message @sample, :create, :notice
			redirect_to @sample
		else
			flash[:notice] = @sample.errors_to_s
			render :new
		end
	end

	def update
		if @sample.update update_params
			flash_message @sample, :update, :notice
			redirect_to @sample
		else
			render :edit
		end
	end

	def destroy
		@sample.destroy
		if @sample.destroyed?
			flash_message @sample, :destroy, :notice
			redirect_to samples_url
		else
			flash_message @sample, :destroy, :error
			redirect_to @sample
		end
	end

	private
	def create_params
		params.require(:sample).permit(:file)
	end

	def update_params
		params.require(:sample).permit(:sample_code, :lab_code, :unit_id, :lubricant_id, :taked_at, :received_at, :reported_at)
	end
end
