unless defined?(Hancock) && Hancock.respond_to?(:orm) && [:active_record, :mongoid].include?(Hancock.orm)
  puts "please use hancock_cms_mongoid or hancock_cms_activerecord"
  puts "also: please use hancock_cms_mongoid or hancock_cms_activerecord and not hancock_cms directly"
  exit 1
end

require "hancock/catalog/version"
require 'hancock/catalog/engine'
require 'hancock/catalog/configuration'

require 'hancock/catalog/routes'

require 'money-rails'
# require 'mongoid_money_field'

module Hancock::Catalog
  # Hancock::register_plugin(self)

  class << self
    def orm
      Hancock.orm
    end
    def mongoid?
      Hancock::Catalog.orm == :mongoid
    end
    def active_record?
      Hancock::Catalog.orm == :active_record
    end
    def model_namespace
      "Hancock::Catalog::Models::#{Hancock::Catalog.orm.to_s.camelize}"
    end
    def orm_specific(name)
      "#{model_namespace}::#{name}".constantize
    end
  end

  autoload :Admin,  'hancock/catalog/admin'
  module Admin
    autoload :Item,           'hancock/catalog/admin/item'
    autoload :Category,       'hancock/catalog/admin/category'
    autoload :ItemImage,      'hancock/catalog/admin/item_image'
    autoload :CategoryImage,  'hancock/catalog/admin/category_image'
  end

  module Models
    autoload :Item,           'hancock/catalog/models/item'
    autoload :Category,       'hancock/catalog/models/category'
    autoload :ItemImage,      'hancock/catalog/models/item_image'
    autoload :CategoryImage,  'hancock/catalog/models/category_image'

    module Mongoid
      autoload :Item,           'hancock/catalog/models/mongoid/item'
      autoload :Category,       'hancock/catalog/models/mongoid/category'
      autoload :ItemImage,      'hancock/catalog/models/mongoid/item_image'
      autoload :CategoryImage,  'hancock/catalog/models/mongoid/category_image'
    end

    # module ActiveRecord
    #   autoload :Item,           'hancock/catalog/models/active_record/item'
    #   autoload :Category,       'hancock/catalog/models/active_record/category'
    #   autoload :ItemImage,      'hancock/catalog/models/active_record/item_image'
    #   autoload :CategoryImage,  'hancock/catalog/models/active_record/category_image'
    # end
  end

  module Controllers
    autoload :Items,            'hancock/catalog/controllers/items'
    autoload :Categories,       'hancock/catalog/controllers/categories'
  end

end
