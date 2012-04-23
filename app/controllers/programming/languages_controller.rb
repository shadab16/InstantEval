class Programming::LanguagesController < ApplicationController

	before_filter :authenticate_user!, except: [:index, :show]
	load_and_authorize_resource :language, class: ProgrammingLanguage

	def index
		@languages = ProgrammingLanguage.all
	end

	def show
	end

	def new
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
	end

	def update
		if @language.update_attributes(params[:programming_language])
			flash[:success] = "Programming Language Selection Updated!"
			redirect_to @language
		else
			render :edit
		end
	end

	def destroy
		@language.destroy
		flash[:success] = "Programming Language Selection Destroyed!"
		redirect_to programming_languages_path
	end

end
