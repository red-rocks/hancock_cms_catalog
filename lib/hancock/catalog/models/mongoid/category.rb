module Hancock::Catalog
  module Models
    module Mongoid
      module Category
        extend ActiveSupport::Concern
        include Hancock::HtmlField

        included do
          index({enabled: 1, lft: 1}, {background: true})
          index({parent_id: 1},       {background: true})

          field :name, type: String, localize: Hancock::Catalog.configuration.localize, default: ""

          acts_as_nested_set
          scope :sorted, -> { order_by([:lft, :asc]) }

          hancock_cms_html_field :excerpt,   type: String, localize: Hancock::Catalog.configuration.localize, default: ""
          hancock_cms_html_field :content,   type: String, localize: Hancock::Catalog.configuration.localize, default: ""

          if Hancock::Catalog.config.gallery_support
            embeds_many :category_images, cascade_callbacks: true, class_name: "Hancock::Catalog::CategoryImage"
            alias :images :category_images
            accepts_nested_attributes_for :category_images, allow_destroy: true
          end
        end

        def items
          item_class.in(category_ids: self.id)
        end

        def all_items
          item_class.any_in(category_ids: self.self_and_descendants.map(&:id))
        end
      end
    end
  end
end
