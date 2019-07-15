module Hancock::Catalog::ItemsPaging
  extend ActiveSupport::Concern

  included do |base|

    if Hancock::Catalog.config.model_settings_support
      model_setting :per_page, kind: :integer, default: Hancock::Catalog.config.items_per_page
    end
  end

  class_methods do

    def per_page
      if Hancock::Catalog.config.model_settings_support
        # settings.per_page(kind: :integer, default: Hancock::Catalog.config.items_per_page)
        settings.per_page#(kind: :integer, default: Hancock::Catalog.config.items_per_page)
      else
        Hancock::Catalog.config.items_per_page
      end
    end

  end

end