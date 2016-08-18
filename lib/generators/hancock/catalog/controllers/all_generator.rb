require 'rails/generators'

module Hancock::Catalog::Controllers
  class AllGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :class_name, type: :string
    argument :category_class_name_arg, type: :string, default: ""

    desc 'Hancock::Catalog Controllers generator'
    def all
      generate "hancock:catalog:controllers:item #{camelcased_class_name}"
      generate "hancock:catalog:controllers:category #{category_class_name}"
    end

    private
    def capitalized_class_name
      class_name.capitalize
    end
    def camelcased_class_name
      class_name.camelcase
    end

    def category_class_name
      category_class_name_arg.blank? ? "#{camelcased_class_name}Category" : category_class_name_arg
    end

  end
end
