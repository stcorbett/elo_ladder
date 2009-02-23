class Settings
  
  def self.method_missing(method, *args)
    @config ||= YAML::load(File.open("#{RAILS_ROOT}/config/settings.yml"))
    @config[method.to_s]
  end
  
end