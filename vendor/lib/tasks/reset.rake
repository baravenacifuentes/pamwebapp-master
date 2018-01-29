namespace :db do
	namespace :migrate do
		desc "Runs db:migrate:reset and db:seed"
		task :setup do |task, args|
			sh %{ rails db:migrate:reset }
			sh %{ rails db:seed }
		end
	end
end
