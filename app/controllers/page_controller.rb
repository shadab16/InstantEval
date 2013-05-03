class PageController < ApplicationController

	def home
		@languages = ProgrammingLanguage.all
		@tasks = ProgrammingTask.order('created_at DESC').limit(10)
	end

	def about
	end

	def contact
	end

end
