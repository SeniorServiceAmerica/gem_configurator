require "gem_configurator/version"
require 'active_support/inflector'
require 'erb'

module GemConfigurator

  attr_reader :settings
  
  private
  
  def config_path
    config_file_name = "#{self.class.to_s.demodulize.underscore}.yml"
    if using_rails? && File.exists?(Rails.root.join("config",config_file_name))
      Rails.root.join("config",config_file_name)
    elsif File.exists?("config/#{config_file_name}")
      File.path("config/#{config_file_name}")
    else
      nil
    end
  end
  
  def configure
    raw_settings = parse_yaml(config_path())
    environment = using_rails? ? Rails.env : 'development'
    
    if raw_settings
      @settings = raw_settings[environment]
    else
      @settings = {}          
    end
    
    if self.respond_to?(:default_settings,true)
      @settings = default_settings.merge(@settings)
    else
      @settings
    end
  end
  
  def parse_yaml(path)
    path ? YAML.load(ERB.new(File.read(path)).result) : nil
  end
  
  def using_rails?
    defined?(Rails)
  end
end
