class UsersController < ApplicationController

	def show
		@user = User.find_by_id(params[:id]) || not_found
	end
end
