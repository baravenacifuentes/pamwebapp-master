class CreateGears < ActiveRecord::Migration[5.0]
	def change
		create_table :gears do |t|
			t.references :type, foreign_key: true
			t.string :name
			t.integer :current_state, default: 0
			t.datetime :deadline

			t.timestamps
		end
	end
end
