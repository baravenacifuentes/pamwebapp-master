class CreateTypes < ActiveRecord::Migration[5.0]
	def change
		create_table :types do |t|
			t.string :type
			t.string :name
			t.integer :worst_sample_id
			t.integer :worst_sample_deadline_id

			t.timestamps
		end
	end
end
