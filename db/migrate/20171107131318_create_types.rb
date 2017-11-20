class CreateTypes < ActiveRecord::Migration[5.0]
	def change
		create_table :types do |t|
			t.string :type
			t.string :name
			t.integer :current_state, default: 0
			t.datetime :deadline

			t.timestamps
		end
	end
end
