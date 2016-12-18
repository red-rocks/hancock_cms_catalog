module Hancock::Catalog
  module Admin
    module Item
      def self.config(nav_label = nil, fields = {})
        if nav_label.is_a?(Hash)
          nav_label, fields = nav_label[:nav_label], nav_label
        elsif nav_label.is_a?(Array)
          nav_label, fields = nil, nav_label
        end

        Proc.new {
          navigation_label(!nav_label.blank? ? nav_label : I18n.t("hancock.catalog"))

          list do
            scopes [:sorted, :enabled, nil]

            field :enabled, :toggle do
              searchable false
            end
            field :name do
              searchable true
            end
            field :categories do
              # searchable :name
            end
            if Hancock::Catalog.config.pages_support and Hancock::Catalog.configuration.can_connect_items_with_pages
              field :connected_pages, :hancock_connectable
            end
          end

          edit do
            field :enabled, :toggle
            field :name
            if Hancock::Catalog.config.pages_support and Hancock::Catalog.configuration.can_connect_items_with_pages
              group :connected_pages do
                active false
                field :connected_pages, :hancock_connectable do
                  read_only do
                    !bindings[:view].current_user.admin?
                  end
                end
              end
            end
            group :categories do
              active false
              field :main_category
              field :categories
            end
            field :price, :string
            # field :price, :money_field

            group :URL, &Hancock::Admin.url_block
            # group :URL do
            #   active false
            #   field :slugs, :hancock_slugs
            #   field :text_slug
            # end

            if Hancock::Catalog.config.gallery_support
              group :image, &Hancock::Gallery::Admin.images_block(:item_images)
              # group :image do
              #   active false
              #   field :image, :hancock_image
              #   field :item_images
              # end
            end


            group :content, &Hancock::Admin.content_block
            # group :content do
            #   active false
            #   field :excerpt, :hancock_html
            #   field :content, :hancock_html
            # end

            Hancock::RailsAdminGroupPatch::hancock_cms_group(self, fields)

            if Hancock::Catalog.config.seo_support
              group :seo_n_sitemap, &Hancock::Seo::Admin.seo_n_sitemap_block
            end
            # if Hancock::Catalog.config.seo_support
            #   group :seo do
            #     active false
            #     field :seo
            #   end
            #   group :sitemap_data do
            #     active false
            #     field :sitemap_data
            #   end
            # end

            if Hancock::Catalog.config.cache_support
              group :caching, &Hancock::Cache::Admin.caching_block
            end
          end

          nested_set({max_depth: 1, scopes: []})

          sort_embedded(
              {
                  fields: [:item_images]
              }
          )

          if defined?(RailsAdminMultipleFileUpload)
            multiple_file_upload(
                {
                    fields: [:item_images]
                }
            )
          end

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
