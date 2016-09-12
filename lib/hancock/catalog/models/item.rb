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

        def self.manager_can_add_actions
          ret = [:nested_set]
          ret += [:multiple_file_upload, :sort_embedded] if Hancock::Catalog.mongoid?
          ret << :model_settings if Hancock::Catalog.config.model_settings_support
          ret << :model_accesses if Hancock::Catalog.config.user_abilities_support
          ret << :multiplre if Hancock::Catalog.config.user_abilities_support
          ret += [:comments, :model_comments] if Hancock::Catalog.config.ra_comments_support
          ret.freeze
        end
        def self.rails_admin_add_visible_actions
          ret = [:nested_set]
          ret += [:multiple_file_upload, :sort_embedded] if Hancock::Catalog.mongoid?
          ret << :model_settings if Hancock::Catalog.config.model_settings_support
          ret << :model_accesses if Hancock::Catalog.config.user_abilities_support
          ret += [:comments, :model_comments] if Hancock::Catalog.config.ra_comments_support
          ret.freeze
        end
      end

      def image_styles
        Hancock::Catalog.configuration.item_image_styles
      end

    end
  end
end
