# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ra = Role.create name: :admin
Role.create name: :analyst
Role.create name: :plant

u = User.new email: 'admin@pamwebapp.com', password: 'password', password_confirmation: 'password', name: 'Pam', surname: 'WebApp', second_surname: 'Admin', roles: [ra]
u.skip_confirmation!
u.save!

gt1 = GearType.create name: 'Equipos Terrestres'

g1 = Gear.create name: 'Pala #1', type: gt1
g2 = Gear.create name: 'Correa #23', type: gt1

c1 = Component.create name: 'Portarodamiento', gear: g1
c2 = Component.create name: 'Banda FS34', gear: g2

l = Lubricant.create name: 'Shell Omala S2 G 460', max_days: 2

u1 = Unit.create name: 'Industrial Gearbox', component: c1, lubricant: l

u2 = Unit.create name: 'Industrial Gearbox', component: c2, lubricant: l


vt1 = VariableType.create name: 'Fe'
vt2 = VariableType.create name: 'Ca'
vt3 = VariableType.create name: 'P'
vt4 = VariableType.create name: 'Zn'
vt5 = VariableType.create name: 'B'

v1 = Variable.create min: 60, mid: 70, max: 150, lubricant: l, type: vt1
v2 = Variable.create min: 34, mid:70, max: 120, lubricant: l, type: vt2
v3 = Variable.create min: 12, mid: 70, max: 90, lubricant: l, type: vt3
v4 = Variable.create min: 65, mid: 70, max: 85, lubricant: l, type: vt4
v5 = Variable.create min: 70, mid: 80, max: 130, lubricant: l, type: vt5

s = Sample.create internal_id: '320PP104', taked_at: (DateTime.now - 3.days), received_at: (DateTime.now - 2.days), reported_at: (DateTime.now - 1.day), unit: u1, lubricant: l

sv1 = SampleVariable.create value: 123, variable: v1, sample: s
sv2 = SampleVariable.create value: 6, variable: v2, sample: s
sv3 = SampleVariable.create value: 123, variable: v3, sample: s
sv4 = SampleVariable.create value: 146, variable: v4, sample: s
sv5 = SampleVariable.create value: 188, variable: v5, sample: s

s.update_state
