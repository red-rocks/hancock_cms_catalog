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
        # if Hancock::Catalog.config.watermark_support
        #   include Hancock::Gallery::Watermarkable
        # end
      end
      # include Mongoid::MoneyField

      include Hancock::Cacheable

      include Hancock::Catalog.orm_specific('Item')

      include ManualSlug

      included do
        belongs_to :main_category, class_name: "Hancock::Catalog::Category", inverse_of: nil
        before_validation :set_default_main_category
        def set_default_main_category(force = false)
          if force or main_category.blank? or !main_category.enabled and self.respond_to?(:categories)
            self.main_category = self.categories.enabled.sorted.first
          end
        end

        manual_slug :name

        if Hancock::Catalog.config.pages_support and Hancock::Catalog.configuration.can_connect_items_with_pages
          hancock_connectable_field :connected_pages
        end

        if Hancock::Catalog.config.gallery_support and Hancock::Catalog.configuration.item_image_styles
          set_default_auto_crop_params_for(:image)
          hancock_cms_attached_file(:image)
          # if Hancock::Gallery.config.watermark_support
          #   paperclip_with_watermark(:image)
          # else
          #   hancock_cms_attached_file(:image)
          # end
        end

        def self.manager_can_add_actions
          ret = [:nested_set]
          ret += [:multiple_file_upload, :sort_embedded] if Hancock::Catalog.mongoid?
          ret << :model_settings if Hancock::Catalog.config.model_settings_support
          ret << :model_accesses if Hancock::Catalog.config.user_abilities_support
          ret << :hancock_touch if Hancock::Catalog.config.cache_support
          ret += [:comments, :model_comments] if Hancock::Catalog.config.ra_comments_support
          ret.freeze
        end
        def self.rails_admin_add_visible_actions
          ret = [:nested_set]
          ret += [:multiple_file_upload, :sort_embedded] if Hancock::Catalog.mongoid?
          ret << :model_settings if Hancock::Catalog.config.model_settings_support
          ret << :model_accesses if Hancock::Catalog.config.user_abilities_support
          ret << :hancock_touch if Hancock::Catalog.config.cache_support
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
