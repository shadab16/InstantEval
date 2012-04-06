class RemoveLanguagesFromProgrammingTasks < ActiveRecord::Migration
  def up
    remove_column :programming_tasks, :languages
      end

  def down
    add_column :programming_tasks, :languages, :string
  end
end
