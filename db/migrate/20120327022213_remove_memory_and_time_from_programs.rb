class RemoveMemoryAndTimeFromPrograms < ActiveRecord::Migration
  def up
    remove_column :programs, :memory
        remove_column :programs, :time
      end

  def down
    add_column :programs, :time, :string
    add_column :programs, :memory, :string
  end
end
