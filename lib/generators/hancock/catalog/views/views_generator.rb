require 'rails/generators'

module Hancock::Catalog
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../../../../app/views/hancock/catalog', __FILE__)
    argument :views_args, type: :array, default: []

    desc 'Hancock::Catalog Config generator'
    def views
      (views_args == ['all'] ? permitted_file_views : ((views_args & permitted_path_views).map { |v| permitted_file_views(v) }.flatten)).each do |v|
        copy_file "#{v}.html.slim", "app/views/hancock/catalog/#{v}.html.slim"
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
      permitted_views.reject { |v| v.index("#{path}/").nil? }
    end

    def permitted_path_views
      permitted_views.select { |v| v.index('/').nil? }
    end

  end
end
