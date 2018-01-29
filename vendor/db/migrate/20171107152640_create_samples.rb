class CreateSamples < ActiveRecord::Migration[5.0]
	def change
		create_table :samples do |t|
			t.string :sample_code
			t.string :lab_code
			t.references :unit, foreign_key: true
			t.date :taked_at
			t.date :received_at
			t.date :reported_at
			t.integer :state, default: 0

			t.timestamps
		end
	end
end
