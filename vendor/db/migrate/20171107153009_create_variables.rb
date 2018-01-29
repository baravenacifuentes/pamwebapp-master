class CreateVariables < ActiveRecord::Migration[5.0]
	def change
		create_table :variables do |t|
			t.float :min
			t.float :mid
			t.float :max
			t.references :lubricant, foreign_key: true
			t.references :type, foreign_key: true

			t.timestamps
		end
	end
end
