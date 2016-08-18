require 'rails/generators'

module Hancock::Catalog
  class AllGenerator < Rails::Generators::Base
    argument :class_name, type: :string

    desc 'Hancock::Catalog generator'
    def all
      generate "hancock:catalog:config:install"

      generate "hancock:catalog:models:all #{class_name}"

      generate "hancock:catalog:controllers:all #{class_name}"
    end

  end
end
