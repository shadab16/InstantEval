class CreateProgrammingTasks < ActiveRecord::Migration
  def change
    create_table :programming_tasks do |t|
      t.text :statement
      t.text :input_format
      t.string :languages
      t.string :limits

      t.timestamps
    end
  end
end
