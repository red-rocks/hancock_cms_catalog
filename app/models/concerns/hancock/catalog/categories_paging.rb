module Hancock::Catalog::CategoriesPaging
  extend ActiveSupport::Concern

  included do

    if Hancock::Catalog.config.model_settings_support
      model_setting :per_page, kind: :integer, default: Hancock::Catalog.config.categories_per_page
      model_setting :items_per_page, kind: :integer, default: Hancock::Catalog.config.items_per_page
    end
    
  end


  class_methods do

    def per_page
      if Hancock::Catalog.config.model_settings_support
        # settings.per_page(kind: :integer, default: Hancock::Catalog.config.categories_per_page)
        settings.per_page#(kind: :integer, default: Hancock::Catalog.config.categories_per_page)
      else
        Hancock::Catalog.config.categories_per_page
      end
    end

    def items_per_page
      if @category
        @category
      else
        if Hancock::Catalog.config.model_settings_support
          # settings.items_per_page(kind: :integer, default: Hancock::Catalog.config.items_per_page)
          settings.items_per_page#(kind: :integer, default: Hancock::Catalog.config.items_per_page)
        else
          Hancock::Catalog.config.items_per_page
        end
      end      
    end

  end

end