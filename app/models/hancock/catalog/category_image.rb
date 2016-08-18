if Hancock::Catalog.config.gallery_support
  module Hancock::Catalog
    _parent_class = Hancock::Gallery::Image if Hancock::Catalog.active_record?
    _parent_class = Hancock::Gallery::EmbeddedImage if Hancock::Catalog.mongoid?

    class CategoryImage < _parent_class
      include Hancock::Catalog::Models::CategoryImage

      include Hancock::Catalog::Decorators::CategoryImage

      rails_admin(&Hancock::Catalog::Admin::CategoryImage.config(nil, rails_admin_add_fields) { |config|
        rails_admin_add_config(config)
      })
    end
  end
end
