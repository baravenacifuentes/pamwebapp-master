# 01 on name to force alphabetical first initialization
def load_secret_keys(environment = nil)
	if environment.present?
		path = Rails.root.join('config', 'environments', 'keys', "#{environment}.yml")
		return unless File.exist? path
	end
	config = YAML.load(ERB.new(File.new(path).read).result)
	config.each { |key, value| ENV[key.to_s] = value.to_s } if config.present?
end

load_secret_keys(Rails.env)
