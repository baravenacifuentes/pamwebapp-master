class CreateLubricants < ActiveRecord::Migration[5.0]
	def change
		create_table :lubricants do |t|
			t.string :name
			t.integer :max_days

			t.timestamps
		end
	end
end
