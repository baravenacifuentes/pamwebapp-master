role_1 = Role.create name: :admin
role_2 = Role.create name: :analyst
role_3 = Role.create name: :plant

user_1 = User.new email: 'admin@pamwebapp.com', password: 'password', password_confirmation: 'password', name: 'Pam', surname: 'WebApp', second_surname: 'Admin', roles: [role_1]
user_1.skip_confirmation!
user_1.save!

user_2 = User.new email: 'analyst@pamwebapp.com', password: 'password', password_confirmation: 'password', name: 'Pam', surname: 'WebApp', second_surname: 'Analista', roles: [role_2]
user_2.skip_confirmation!
user_2.save!

user_3 = User.new email: 'plant@pamwebapp.com', password: 'password', password_confirmation: 'password', name: 'Pam', surname: 'WebApp', second_surname: 'Planta', roles: [role_3]
user_3.skip_confirmation!
user_3.save!

## GearTypes
gear_type_1 = GearType.create name: 'Equipos Terrestres'

## VariableTypes
variable_type_1 = VariableType.create name: 'Fe'
variable_type_2 = VariableType.create name: 'Ca'
variable_type_3 = VariableType.create name: 'P'
variable_type_4 = VariableType.create name: 'Zn'
variable_type_5 = VariableType.create name: 'B'

## Lubricants
# 720 hours -> 30 days
lubricant_1 = Lubricant.create name: 'Shell Omala S2 G 460', max_hours: 720 do |lubricant|
	lubricant.variables << Variable.new(min: 60, mid: 70, max: 150, type: variable_type_1)
	lubricant.variables << Variable.new(min: 34, mid: 70, max: 120, type: variable_type_2)
	lubricant.variables << Variable.new(min: 12, mid: 70, max: 90,  type: variable_type_3)
	lubricant.variables << Variable.new(min: 65, mid: 70, max: 85,  type: variable_type_4)
	lubricant.variables << Variable.new(min: 65, mid: 80, max: 130, type: variable_type_5)
end

## Gears
##verde
Gear.create name: 'Perforadora', type: gear_type_1 do |gear|
	gear.components << Component.new(name: 'Portarodamiento') do |component|
		component.units << Unit.new(name: 'Industrial Gearbox', lubricant: lubricant_1)
		component.units << Unit.new(name: 'Water Pump', lubricant: lubricant_1)
	end
end
##amarillo
Gear.create name: 'Compresor', type: gear_type_1 do |gear|
	gear.components << Component.new(name: 'Banda FS34') do |component|
		component.units << Unit.new(name: 'Industrial Gearbox', lubricant: lubricant_1)
		component.units << Unit.new(name: 'Power Take Off', lubricant: lubricant_1)
	end
end
##verde
Gear.create name: 'Harnero', type: gear_type_1 do |gear|
	gear.components << Component.new(name: 'Reductor') do |component|
		component.units << Unit.new(name: 'Water Pump', lubricant:lubricant_1)
		component.units << Unit.new(name: 'Bearings-Rollers', lubricant:lubricant_1)
	end
end
##rojo
Gear.create name: 'Chancador', type: gear_type_1 do |gear|
	gear.components << Component.new(name: 'Rodamiento Bomba') do |component|
		component.units << Unit.new(name: 'Industrial Gearbox', lubricant:lubricant_1)
		component.units << Unit.new(name: 'Power Take Off', lubricant: lubricant_1)
	end
end

unit_1 = Unit.find(1)
unit_2 = Unit.find(2)
unit_3 = Unit.find(3)
unit_4 = Unit.find(4)
unit_5 = Unit.find(5)
unit_6 = Unit.find(6)
unit_7 = Unit.find(7)
unit_8 = Unit.find(8)

sample_1 = [70, 70, 70, 70, 70]
unit_1.samples.create(sample_code: '320PP104', lab_code: 'M2181', taked_at: 3.days.ago, received_at: 2.days.ago, reported_at: 1.day.ago) do |sample|
	sample.lubricant.variables.each_with_index do |variable, index|
		sample.sample_variables << SampleVariable.new(value: sample_1[index], variable: variable)
	end
end

sample_2 = [81, 81, 81, 81, 81]
unit_2.samples.create(sample_code: '320PP105', lab_code: 'M2181', taked_at: 3.days.ago, received_at: 2.days.ago, reported_at: 1.day.ago) do |sample|
	sample.lubricant.variables.each_with_index do |variable, index|
		sample.sample_variables << SampleVariable.new(value: sample_2[index], variable: variable)
	end
end

sample_3 = [70, 70, 70, 70, 70]
unit_3.samples.create(sample_code: '320PP106', lab_code: 'M2181', taked_at: 23.days.ago, received_at: 2.days.ago, reported_at: 1.day.ago) do |sample|
	sample.lubricant.variables.each_with_index do |variable, index|
		sample.sample_variables << SampleVariable.new(value: sample_3[index], variable: variable)
	end
end

sample_4 = [123, 6, 123, 146, 188]
unit_4.samples.create(sample_code: '320PP107', lab_code: 'M2181', taked_at: 3.days.ago, received_at: 2.days.ago, reported_at: 1.day.ago) do |sample|
	sample.lubricant.variables.each_with_index do |variable, index|
		sample.sample_variables << SampleVariable.new(value: sample_4[index], variable: variable)
	end
end

sample_5 = [1, 1, 1, 1, 1]
unit_5.samples.create(sample_code: '320PP108', lab_code: 'M2181', taked_at: 3.days.ago, received_at: 2.days.ago, reported_at: 1.day.ago) do |sample|
	sample.lubricant.variables.each_with_index do |variable, index|
		sample.sample_variables << SampleVariable.new(value: sample_5[index], variable: variable)
	end
end

sample_6 = [123, 6, 123, 146, 188]
unit_6.samples.create(sample_code: '320PP109', lab_code: 'M2181', taked_at: 3.days.ago, received_at: 2.days.ago, reported_at: 1.day.ago) do |sample|
	sample.lubricant.variables.each_with_index do |variable, index|
		sample.sample_variables << SampleVariable.new(value: sample_6[index], variable: variable)
	end
end

sample_7 = [123, 6, 123, 146, 188]
unit_7.samples.create(sample_code: '320PP110', lab_code: 'M2181', taked_at: 3.days.ago, received_at: 2.days.ago, reported_at: 1.day.ago) do |sample|
	sample.lubricant.variables.each_with_index do |variable, index|
		sample.sample_variables << SampleVariable.new(value: sample_7[index], variable: variable)
	end
end

sample_8 = [70, 70, 70, 70, 70]
unit_8.samples.create(sample_code: '320PP111', lab_code: 'M2181', taked_at: 31.days.ago, received_at: 2.days.ago, reported_at: 1.day.ago) do |sample|
	sample.lubricant.variables.each_with_index do |variable, index|
		sample.sample_variables << SampleVariable.new(value: sample_8[index], variable: variable)
	end
end
## daynow - 31 rojo
## daynow -  3 verde
## daynow - 23 amarillo
