class Programming::ProgramsController < ApplicationController

	before_filter :authenticate_user!, except: [:show]
	load_and_authorize_resource :task, class: ProgrammingTask
	load_and_authorize_resource :program, class: Program, through: :task

	def show
	end

	def new
		@languages = @task.programming_languages.available
	end

	def create
		@program.user_id = current_user.id
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
		tcmd = "#{Rails.root.join('script/timeout/timeout')} -t %s -m %s"
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
				task = @program.programming_task
				timelimit = task.time_limit
				memlimit = task.memory_limit.megabytes / 1.kilobyte
				timeout = tcmd % [timelimit, memlimit]
				testcases = task.programming_test_cases
				testcases.each do |testcase|
					Open3.popen3("#{timeout} #{out}") do |stdin, stdout, stderr, thread|
						stdin.write testcase.stdin
						stdin.flush
						stdin.close_write
						exit_code = thread.value
						output = stdout.read.gsub(/\r\n?/, "\n").strip
						expected = testcase.stdout
						err = stderr.read
						status = nil
						err.split("\n").reverse.each do |line|
							next if line[0] == "<"
							case line.split.first
							when "TIMEOUT"
								status = codes[:cpu]
							when "HANGUP"
								status = codes[:hang]
							when "MEM"
								status = codes[:mem]
							when "SIGNAL"
								status = codes[:sig]
							end
							break
						end
						if status.nil?
							status = codes[:ok] if output == expected
							status = codes[:fail] if output != expected
							status = codes[:exit] unless exit_code.success?
						else
							output = ""
						end
						@program.program_results.new(
							programming_test_case_id: testcase.id,
							status_code_id: status,
							log: output
						)
						@program.status_code_id = status unless status == codes[:ok]
					end
				end
				@program.status_code_id = codes[:ok] if @program.status_code_id.nil?
			end
			File.delete(out) if File.exist?(out)
		end
	end

end
