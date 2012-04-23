class Programming::TasksController < ApplicationController

	before_filter :authenticate_user!, except: [:index, :show]
	before_filter :fix_params, only: [:new, :create, :update]
	load_and_authorize_resource :task, class: ProgrammingTask

	def index
		@tasks = ProgrammingTask.all
	end

	def show
	end

	def new
		@task.programming_test_cases.build
		@languages = ProgrammingLanguage.available
	end

	def create
		@task = ProgrammingTask.new(params[:programming_task])
		if @task.save
			flash[:success] = "Programming Task Created!"
			redirect_to @task
		else
			@languages = ProgrammingLanguage.available
			@task.programming_test_cases.build if @task.programming_test_cases.blank?
			render :new
		end
	end

	def edit
		@task.programming_test_cases.build
		@languages = ProgrammingLanguage.available
	end

	def update
		if @task.update_attributes(params[:programming_task])
			flash[:success] = "Programming Task Updated!"
			redirect_to @task
		else
			@languages = ProgrammingLanguage.available
			@task.programming_test_cases.build if @task.programming_test_cases.blank?
			render :edit
		end
	end

	def destroy
		@task.destroy
		flash[:success] = "Programming Task Destroyed!"
		redirect_to programming_tasks_path
	end

	private

	def fix_params
		ids = params[:programming_task][:programming_language_ids]
		ids = ids.collect { |k, v| k unless v == '0' }
		params[:programming_task][:programming_language_ids] = ids.compact
	rescue
		# m|n
	end

end
