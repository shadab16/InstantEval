class Programming::TasksController < ApplicationController

	before_filter :fix_params, only: [:new, :create, :update]

	def index
		@tasks = ProgrammingTask.all
	end

	def show
		@task = ProgrammingTask.find_by_id(params[:id]) || not_found
	end

	def new
		@task = ProgrammingTask.new
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
			render :new
		end
	end

	def edit
		@task = ProgrammingTask.find_by_id(params[:id]) || not_found
		@languages = ProgrammingLanguage.available
	end

	def update
		@task = ProgrammingTask.find_by_id(params[:id]) || not_found
		if @task.update_attributes(params[:programming_task])
			flash[:success] = "Programming Task Updated!"
			redirect_to @task
		else
			@languages = ProgrammingLanguage.available
			render :edit
		end
	end

	def destroy
		@task = ProgrammingTask.find_by_id(params[:id]) || not_found
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
