require "gem_configurator/version"

module GemConfigurator
  
  attr_reader :settings
  
  def config_path
    config_file_name = "#{self.class.to_s.underscore}.yml"
    if defined?(Rails) && File.exists?(Rails.root.join("config",config_file_name))
      Rails.root.join("config",config_file_name)
    else
      nil
    end
  end
  
  def configure
    raw_settings = parse_yaml(config_path())

    if raw_settings
      @settings = raw_settings[Rails.env]
    else
      @settings = {}          
    end

    if self.respond_to?(:default_settings,true)
      @settings = default_settings.merge(@settings)
    else
      @settings
    end
  end
  
  def test
    self.private_methods.sort
  end

  def parse_yaml(path)
    path ? YAML.load_file(path) : nil
  end
end
