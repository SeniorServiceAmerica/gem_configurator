# GemConfigurator

Provides a simple, uniform way to configure a gem with a yaml file. Designed to work within a Rails app.

## Installation

Add this line to your application's Gemfile:

    gem 'gem_configurator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gem_configurator

## Usage

Include the module into a class that you wish to configure via YAML.

```ruby
  class Foo
    include GemConfigurator
    
    def initialize()
      configure
      ...
    end
    
    ...
  end
```

Within your rails app, place a config file in the /config directory. The config file's name must match the class's name. For example, to configure Foo, name the file foo.yml.

Example yaml file:

```yaml
  development:
    [setting name]: [setting value]
    ...
  
  test: 
    ...
```    

On instantiation, the settings for your current environment are placed in an instance variable called @settings. Retrieve the settings with `@settings[:setting_name]`

### Default Settings

If you want your object to have default settings, simply define a `default_settings` instance method.

```ruby
  class Foo
    include GemConfigurator
    
    def initialize()
      configure
      ...
    end
    
    def defualt_settings
      {:setting_name => setting_value}
    end
```

Default settings will be merged with any settings defined in the YAML file. YAML file settings will overwrite a default setting of the same name.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
