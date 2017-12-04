class UsersController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	# GET /users
	def index
		@users = @users.page(params[:page])
	end

	# GET /users/1
	def show
	end

	# DELETE /users/1
	def destroy
		@user.destroy
		respond_with @user
	end
end
