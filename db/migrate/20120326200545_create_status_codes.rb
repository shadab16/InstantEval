class CreateStatusCodes < ActiveRecord::Migration
  def change
    create_table :status_codes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
