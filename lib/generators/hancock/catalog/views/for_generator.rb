require 'rails/generators'

module Hancock::Catalog::Views
  class ForGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../../../../app/views/hancock/catalog', __FILE__)
    argument :class_name, type: :string
    argument :views_args, type: :array, default: []

    desc 'Hancock::Catalog Views generator'
    def for
      (views_args == ['all'] ? permitted_file_views : ((views_args & permitted_path_views).map { |v| permitted_file_views(v) }.flatten)).each do |v|
        if v.index('items')
          res_v = "#{underscored_pluralized_class_name}/#{v.gsub(/.*\//, "")}"
        else
          res_v = "#{underscored_singularized_class_name}_categories/#{v.gsub(/.*\//, "")}"
        end
        copy_file "#{v}.html.slim", "app/views/#{res_v}.html.slim"
      end
    end

    private
    def permitted_views
      [
        'categories', 'items',
        'categories/index', 'categories/show',
        'items/index',      'items/show'
      ]
    end

    def permitted_file_views(path = '')
      # permitted_views.reject { |v| v.index("#{path}/").nil? }
      permitted_views.reject { |v| v.index("/").nil? }
    end

    def permitted_path_views
      permitted_views.select { |v| v.index('/').nil? }
    end


    def camelcased_class_name
      class_name.camelcase
    end

    def underscored_class_name
      camelcased_class_name.underscore
    end

    def underscored_pluralized_class_name
      underscored_class_name.pluralize
    end

    def underscored_singularized_class_name
      underscored_class_name.singularize
    end

  end
end
