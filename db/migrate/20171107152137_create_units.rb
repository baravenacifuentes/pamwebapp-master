class CreateUnits < ActiveRecord::Migration[5.0]
	def change
		create_table :units do |t|
			t.references :component, foreign_key: true
			t.references :lubricant, foreign_key: true
			t.string :name
			t.integer :worst_sample_id
			t.integer :worst_sample_deadline_id

			t.timestamps
		end
	end
end
