class Programming::LanguagesController < ApplicationController

	before_filter :authenticate_user!, except: [:index, :show]
	authorize_resource class: ProgrammingLanguage

	def index
		@languages = ProgrammingLanguage.all
	end

	def show
		@language = ProgrammingLanguage.find_by_id(params[:id]) || not_found
	end

	def new
		@language = ProgrammingLanguage.new
	end

	def create
		@language = ProgrammingLanguage.new(params[:programming_language])
		if @language.save
			flash[:success] = "Programming Language Selection Created!"
			redirect_to @language
		else
			render :new
		end
	end

	def edit
		@language = ProgrammingLanguage.find_by_id(params[:id]) || not_found
	end

	def update
		@language = ProgrammingLanguage.find_by_id(params[:id]) || not_found
		if @language.update_attributes(params[:programming_language])
			flash[:success] = "Programming Language Selection Updated!"
			redirect_to @language
		else
			render :edit
		end
	end

	def destroy
		@language = ProgrammingLanguage.find_by_id(params[:id]) || not_found
		@language.destroy
		flash[:success] = "Programming Language Selection Destroyed!"
		redirect_to programming_languages_path
	end

end
