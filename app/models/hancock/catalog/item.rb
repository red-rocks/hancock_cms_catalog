module Hancock::Catalog
  class Item
    include Hancock::Catalog::Models::Item

    include Hancock::Catalog::Decorators::Item

    rails_admin(&Hancock::Catalog::Admin::Item.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
