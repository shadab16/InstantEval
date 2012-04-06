class AddMemoryAndTimeToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :memory, :integer

    add_column :programs, :time, :integer

  end
end
