module Hancock::Catalog
  module Models
    module Item
      extend ActiveSupport::Concern
      include Hancock::Model
      include Hancock::Enableable
      if Hancock::Catalog.config.seo_support
        include Hancock::Seo::Seoable
        include Hancock::Seo::SitemapDataField
      end
      if Hancock::Catalog.config.pages_support
        include Hancock::Pages::Connectable
      end
      if Hancock::Catalog.config.gallery_support
        include Hancock::Gallery::Paperclipable
      end
      # include Mongoid::MoneyField

      include Hancock::Catalog.orm_specific('Item')

      include ManualSlug

      included do
        manual_slug :name

        if Hancock::Catalog.config.pages_support and Hancock::Catalog.configuration.can_connect_items_with_pages
          hancock_connectable_field :connected_pages
        end

        if Hancock::Catalog.config.gallery_support and Hancock::Catalog.configuration.item_image_styles
          hancock_cms_attached_file(:image)
        end
      end

      def image_styles
        Hancock::Catalog.configuration.item_image_styles
      end


      def self.manager_default_actions
        if Hancock::Catalog.config.mongoid?
          _add = [:nested_set, :multiple_file_upload, :sort_embedded]
        else
          _add = []
        end
        super + _add
      end
    end
  end
end
