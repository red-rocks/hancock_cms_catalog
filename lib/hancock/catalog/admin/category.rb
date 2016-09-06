module Hancock::Catalog
  module Admin
    module Category
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
            if Hancock::Catalog.config.pages_support and Hancock::Catalog.configuration.can_connect_category_with_pages
              field :connected_pages, :hancock_connectable
            end
          end

          edit do
            field :enabled, :toggle
            field :name
            if Hancock::Catalog.config.pages_support and Hancock::Catalog.configuration.can_connect_category_with_pages
              group :connected_pages do
                active false
                field :connected_pages, :hancock_connectable do
                  read_only do
                    !bindings[:view].current_user.admin?
                  end
                end
              end
            end
            group :URL do
              active false
              field :slugs, :hancock_slugs
              field :text_slug
            end

            if Hancock::Catalog.config.gallery_support
              group :image do
                active false
                field :image, :hancock_image
                field :category_images
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

            group :items do
              active false
              field :items do
                read_only true
                help 'Список товаров'

                pretty_value do
                  bindings[:object].items.to_a.map { |i|
                    route = (bindings[:view] || bindings[:controller])
                    model_name = i.rails_admin_model
                    route.link_to(i.name, route.rails_admin.show_path(model_name: model_name, id: i.id), title: i.name)
                  }.join("<br>").html_safe
                end
              end
            end
          end

          show do
            field :name
            field :slugs, :enum do
              enum_method do
                :slugs
              end
              visible do
                bindings[:view].current_user.admin?
              end
              multiple do
                true
              end
            end
            field :text_slug
            field :enabled
            field :image
            field :excerpt
            field :content

            Hancock::RailsAdminGroupPatch::hancock_cms_group(self, fields)

            field :items do
              read_only true

              pretty_value do
                bindings[:object].items.to_a.map { |i|
                  route = (bindings[:view] || bindings[:controller])
                  model_name = i.rails_admin_model
                  route.link_to(i.name, route.rails_admin.show_path(model_name: model_name, id: i.id), title: i.name)
                }.join("<br>").html_safe
              end
            end
          end

          nested_set({max_depth: 2, scopes: []})

          sort_embedded(
              {
                  fields: [:category_images]
              }
          )

          if defined?(RailsAdminMultipleFileUpload)
            multiple_file_upload(
                {
                    fields: [:category_images]
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
