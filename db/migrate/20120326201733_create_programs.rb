class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.integer :programming_task_id
      t.integer :user_id
      t.text :source
      t.integer :programming_language_id
      t.string :time
      t.string :memory
      t.integer :status_code_id

      t.timestamps
    end
  end
end
