require 'rails/generators'

module Hancock::Catalog
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Hancock::Catalog Config generator'
    def config
      template 'hancock_catalog.erb', "config/initializers/hancock_catalog.rb"
    end

  end
end
