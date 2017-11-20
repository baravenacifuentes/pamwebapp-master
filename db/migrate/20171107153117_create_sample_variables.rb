class CreateSampleVariables < ActiveRecord::Migration[5.0]
	def change
		create_table :sample_variables do |t|
			t.float :value
			t.references :sample, foreign_key: true
			t.references :variable, foreign_key: true

			t.timestamps
		end
	end
end
