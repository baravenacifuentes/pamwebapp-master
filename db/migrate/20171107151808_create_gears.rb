class CreateGears < ActiveRecord::Migration[5.0]
	def change
		create_table :gears do |t|
			t.references :type, foreign_key: true
			t.string :name
			t.integer :worst_sample_id

			t.timestamps
		end
	end
end
