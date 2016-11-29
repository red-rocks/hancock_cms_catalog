module Hancock::Catalog
  module Controllers
    module Items
      extend ActiveSupport::Concern

      included do
        if Hancock::Catalog.config.breadcrumbs_on_rails_support
          add_breadcrumb I18n.t('hancock.breadcrumbs.items'), :hancock_items_path, if: :insert_items_breadcrumbs
        end
      end

      def index
        @items = item_class.enabled.sorted.page(params[:page])
        insert_category_breadcrumbs if insert_breadcrumbs

        unless Hancock::Catalog.config.items_per_page.nil?
          @items = @items.page(params[:page]).per(Hancock::Catalog.config.items_per_page)
        end
      end

      def show
        @item = item_class.enabled.find(params[:id])

        if @item and @item.text_slug != params[:id]
          redirect_to hancock_catalog_item_path(@item), status_code: 301
          return true
        end

        if Hancock::Catalog.config.breadcrumbs_on_rails_support
          insert_category_breadcrumbs if insert_breadcrumbs
          add_breadcrumb @item.name, hancock_catalog_item_path(@item), if: :insert_breadcrumbs
        end
      end

      private
      def category_class
        Hancock::Catalog::Category
      end
      def item_class
        Hancock::Catalog::Item
      end
      def page_title
        if @item
          @item.page_title
        else
          super
        end
      end

      def insert_breadcrumbs
        true
      end
      def insert_items_breadcrumbs
        true
      end
      def insert_category_breadcrumbs
      end

    end
  end
end
