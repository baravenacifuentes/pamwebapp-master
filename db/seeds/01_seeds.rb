# role_1 = Role.create name: :admin
# role_2 = Role.create name: :analyst
# role_3 = Role.create name: :plant

# user_1 = User.new email: 'admin@pamwebapp.com', password: 'password', password_confirmation: 'password', name: 'Pam', surname: 'WebApp', second_surname: 'Admin', roles: [role_1]
# user_1.skip_confirmation!
# user_1.save!

# ## GearTypes
# gear_type_1 = GearType.create name: 'Equipos Terrestres'

# ## VariableTypes
# variable_type_1 = VariableType.create name: 'Fe'
# variable_type_2 = VariableType.create name: 'Ca'
# variable_type_3 = VariableType.create name: 'P'
# variable_type_4 = VariableType.create name: 'Zn'
# variable_type_5 = VariableType.create name: 'B'

# ## Lubricants
# # 2160 hours -> 90 days
# lubricant_1 = Lubricant.create name: 'Shell Omala S2 G 460', max_hours: 2160 do |lubricant|
# 	lubricant.variables << Variable.new(min: 60, mid: 70, max: 150, type: variable_type_1)
# 	lubricant.variables << Variable.new(min: 34, mid: 70, max: 120, type: variable_type_2)
# 	lubricant.variables << Variable.new(min: 12, mid: 70, max: 90,  type: variable_type_3)
# 	lubricant.variables << Variable.new(min: 65, mid: 70, max: 85,  type: variable_type_4)
# 	lubricant.variables << Variable.new(min: 70, mid: 80, max: 130, type: variable_type_5)
# end

# ## Gears
# Gear.create name: 'Pala #1', type: gear_type_1 do |gear|
# 	gear.components << Component.new(name: 'Portarodamiento') do |component|
# 		component.units << Unit.new(name: 'Industrial Gearbox', lubricant: lubricant_1)
# 	end
# end

# Gear.create name: 'Correa #23', type: gear_type_1 do |gear|
# 	gear.components << Component.new(name: 'Banda FS34') do |component|
# 		component.units << Unit.new(name: 'Industrial Gearbox', lubricant: lubricant_1)
# 	end
# end

# unit_1 = Unit.find(1)

# sample_1 = [123, 6, 123, 146, 188]

# unit_1.samples.create(internal_id: '320PP104', taked_at: 3.days.ago, received_at: 2.days.ago, reported_at: 1.day.ago) do |sample|
# 	sample.lubricant.variables.each_with_index do |variable, index|
# 		sample.sample_variables << SampleVariable.new(value: sample_1[index], variable: variable)
# 	end
# end
