class CreateProgramResults < ActiveRecord::Migration
  def change
    create_table :program_results do |t|
      t.integer :program_id
      t.integer :programming_test_case_id
      t.integer :status_code_id
      t.integer :time
      t.integer :memory
      t.text :log

      t.timestamps
    end
  end
end
