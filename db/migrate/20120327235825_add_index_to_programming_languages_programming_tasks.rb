class AddIndexToProgrammingLanguagesProgrammingTasks < ActiveRecord::Migration
	def change
		add_index :programming_languages_programming_tasks,
				  [:programming_language_id, :programming_task_id],
				  unique: true,
				  name: 'index_plpt_on_langs_and_tasks' #generated name was too long
	end
end
