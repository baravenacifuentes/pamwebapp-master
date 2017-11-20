class CreateComponents < ActiveRecord::Migration[5.0]
	def change
		create_table :components do |t|
			t.string :name
			t.references :gear, foreign_key: true
			t.integer :current_state, default: 0
			t.datetime :deadline

			t.timestamps
		end
	end
end
