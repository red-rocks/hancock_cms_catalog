module Hancock::Catalog
  module Admin
    module Item
      def self.config(fields = {})
        Proc.new {
          navigation_label I18n.t("hancock.catalog")

          list do
            scopes [:sorted, :enabled, nil]

            field :enabled, :toggle do
              searchable false
            end
            field :name do
              searchable true
            end
            field :categories do
              searchable :name
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
            field :categories do
              searchable :name
            end
            field :price, :string
            # field :price, :money_field

            group :URL do
              active false
              field :slugs, :hancock_slugs
              field :text_slug
            end

            if Hancock::Catalog.config.gallery_support
              group :image do
                active false
                field :image, :hancock_image
                field :item_images
              end
            end

            group :content do
              active false
              field :excerpt, :hancock_html
              field :content, :hancock_html
            end

            Hancock::RailsAdminGroupPatch::hancock_cms_group(self, fields)

            if Hancock::Catalog.config.seo_support
              group :seo do
                active false
                field :seo
              end
              group :sitemap_data do
                active false
                field :sitemap_data
              end
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
