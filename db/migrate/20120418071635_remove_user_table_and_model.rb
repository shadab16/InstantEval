class RemoveUserTableAndModel < ActiveRecord::Migration
	def up
		drop_table :users
	end

	def down
		create_table "users", :force => true do |t|
			t.string   "name"
			t.string   "email"
			t.datetime "created_at",      :null => false
			t.datetime "updated_at",      :null => false
			t.string   "password_digest"
		end

		add_index "users", ["email"], :name => "index_users_on_email", :unique => true
		add_index "users", ["name"], :name => "index_users_on_name", :unique => true
	end
end
