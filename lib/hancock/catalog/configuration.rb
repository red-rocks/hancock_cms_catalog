module Hancock::Catalog
  include Hancock::PluginConfiguration

  def self.config_class
    Configuration
  end

  class Configuration
    attr_accessor :item_image_styles
    attr_accessor :items_per_page

    attr_accessor :item_images_image_styles

    attr_accessor :category_image_styles
    attr_accessor :category_per_page

    attr_accessor :category_images_image_styles

    attr_accessor :gallery_support
    attr_accessor :seo_support
    attr_accessor :pages_support

    attr_accessor :breadcrumbs_on_rails_support

    attr_accessor :can_connect_items_with_pages
    attr_accessor :can_connect_category_with_pages

    attr_accessor :localize

    def initialize
      @item_image_styles  = {
        thumb: '128x128'
      }
      @items_per_page      = 10

      @item_images_image_styles = {
        thumb: '128x128'
      }

      @category_image_styles = {
        thumb: '128x128'
      }
      @category_per_page     = 10

      @category_images_image_styles = {
        thumb: '128x128'
      }

      @gallery_support = defined?(Hancock::Gallery)
      @seo_support = defined?(Hancock::Seo)
      @pages_support = defined?(Hancock::Pages)

      @breadcrumbs_on_rails_support = defined?(BreadcrumbsOnRails)

      @can_connect_items_with_pages = true
      @can_connect_category_with_pages = true

      @localize = Hancock.config.localize
    end
  end
end
