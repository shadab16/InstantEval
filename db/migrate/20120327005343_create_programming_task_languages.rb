class CreateProgrammingTaskLanguages < ActiveRecord::Migration
  def change
    create_table :programming_task_languages, id: false do |t|
      t.integer :programming_task_id
      t.integer :programming_language_id
    end
  end
end
