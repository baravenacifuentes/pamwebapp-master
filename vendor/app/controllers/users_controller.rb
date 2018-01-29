class UsersController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		@users = @users.page(params[:page])
	end

	def show
	end

	def destroy
		@user.destroy
		if @user.destroyed?
			flash_message @user, :destroy, :notice
			redirect_to users_url
		else
			flash_message @user, :destroy, :error
			redirect_to @user
		end
	end
end
