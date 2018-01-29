class CreateTypes < ActiveRecord::Migration[5.0]
	def change
		create_table :types do |t|
			t.string :type
			t.string :name
			t.integer :worst_sample_id
			t.datetime :worst_deadline

			t.timestamps
		end
	end
end