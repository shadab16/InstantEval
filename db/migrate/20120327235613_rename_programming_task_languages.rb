class RenameProgrammingTaskLanguages < ActiveRecord::Migration
	def change
		rename_table :programming_task_languages, :programming_languages_programming_tasks
	end
end
