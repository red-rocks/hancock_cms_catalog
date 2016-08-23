require 'rails/generators'

module Hancock::Catalog::Models
  class DecoratorsGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../../../../app/models/concerns/hancock/catalog/decorators', __FILE__)
    argument :models, type: :array, default: []

    desc 'Hancock::Catalog Models generator'
    def decorators
      (models == ['all'] ? permitted_models : models & permitted_models).each do |m|
        copy_file "#{m}.rb", "app/models/concerns/hancock/catalog/decorators/#{m}.rb"
      end
    end

    private
    def permitted_models
      ['category', 'item', 'category_image', 'item_image']
    end

  end
end
