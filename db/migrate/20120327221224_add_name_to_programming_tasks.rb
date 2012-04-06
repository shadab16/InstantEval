class AddNameToProgrammingTasks < ActiveRecord::Migration
  def change
    add_column :programming_tasks, :name, :string

  end
end
