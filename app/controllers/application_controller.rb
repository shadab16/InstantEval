class ApplicationController < ActionController::Base

	protect_from_forgery

	def not_found
		raise ActionController::RoutingError.new("Sorry! Content not found.")
	end

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to root_url, alert: exception.message
	end
end
