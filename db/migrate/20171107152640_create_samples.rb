class CreateSamples < ActiveRecord::Migration[5.0]
	def change
		create_table :samples do |t|
			t.string :internal_id
			t.references :unit, foreign_key: true
			t.references :lubricant, foreign_key: true
			t.datetime :taked_at
			t.datetime :received_at
			t.datetime :reported_at

			t.timestamps
		end
	end
end
