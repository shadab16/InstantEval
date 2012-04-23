class UsersController < ApplicationController

	before_filter :authenticate_user!, except: [:show]

	def show
		@user = User.find_by_id(params[:id]) || not_found
	end

	def edit
		@user = User.find_by_id(params[:id]) || not_found
	end

	def update
		@user = User.find_by_id(params[:id]) || not_found
		@user.roles = params[:user][:roles]
		if @user.save
			flash[:success] = "User Roles Updated!"
			redirect_to @user
		else
			render :edit
		end
	end
end
