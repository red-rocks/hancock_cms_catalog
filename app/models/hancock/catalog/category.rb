module Hancock::Catalog
  class Category
    include Hancock::Catalog::Models::Category

    include Hancock::Catalog::Decorators::Category

    rails_admin(&Hancock::Catalog::Admin::Category.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
