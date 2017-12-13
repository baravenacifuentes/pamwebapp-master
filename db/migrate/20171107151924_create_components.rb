class CreateComponents < ActiveRecord::Migration[5.0]
	def change
		create_table :components do |t|
			t.string :name
			t.references :gear, foreign_key: true
			t.integer :worst_sample_id

			t.timestamps
		end
	end
end
