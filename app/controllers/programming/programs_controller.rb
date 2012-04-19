class Programming::ProgramsController < ApplicationController

	def show
		@task = ProgrammingTask.find_by_id(params[:task_id]) || not_found
		@program = @task.programs.find_by_id(params[:id]) || not_found
	end

	def new
		@task = ProgrammingTask.find_by_id(params[:task_id]) || not_found
		@program = @task.programs.new
		@languages = @task.programming_languages.available
	end

	def create
		@task = ProgrammingTask.find_by_id(params[:task_id]) || not_found
		@program = @task.programs.new(params[:program])
		evaluate if @program.valid?
		if @program.save
			flash[:success] = "Program Submitted!"
			redirect_to [@task, @program]
		else
			@languages = @task.programming_languages.available
			render :new
		end
	end

	def destroy
		@task = ProgrammingTask.find_by_id(params[:task_id]) || not_found
		@program = @task.programs.find_by_id(params[:id]) || not_found
		@program.destroy
		flash[:success] = "Program Submission Destroyed!"
		redirect_to @task
	end

	private

	# Temporary method for evaluating source code.
	# The code is compiled and executed synchorously,
	# blocking the web application thread till it finishes.
	def evaluate
		# :mem, :cpu, :hang, :sig, :ok, :exit, :compile, :fail
		codes = {}
		StatusCode.all.each { |c| codes[c.name.downcase.to_sym] = c.id }
		lang = @program.programming_language_id
		cmd = {
			1 => 'gcc -x c -O2 -o %s %s',
			2 => 'g++ -x c++ -O2 -o %s %s'
		}
		return unless [1, 2].include?(lang)
		Tempfile.open('src', Rails.root.join('tmp')) do |file|
			file.write(@program.source_code)
			file.flush
			out = File.dirname(file.path) + '/test'
			Open3.popen2e(cmd[lang] % [out, file.path]) do |_, _, thread|
				exit_code = thread.value
				unless exit_code.success?
					@program.status_code_id = codes[:compile]
					next
				end
				testcases = @program.programming_task.programming_test_cases
				testcases.each do |testcase|
					Open3.popen2e(out) do |stdin, stdout, thread|
						stdin.write testcase.stdin
						stdin.flush
						stdin.close_write
						exit_code = thread.value
						output = stdout.read.gsub(/\r\n?/, "\n").strip
						expected = testcase.stdout
						status = codes[:ok] if output == expected
						status = codes[:fail] if output != expected
						status = codes[:exit] unless exit_code.success?
						@program.program_results.new(
							programming_test_case_id: testcase.id,
							status_code_id: status,
							log: output
						)
					end
				end
			end
			File.delete(out)
		end
	end

end
