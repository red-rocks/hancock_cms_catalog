module Hancock::Catalog
  module Models
    module Mongoid
      module Item
        extend ActiveSupport::Concern

        include Hancock::HtmlField

        included do
          field :name, type: String, localize: Hancock::Catalog.configuration.localize, default: ""

          acts_as_nested_set
          scope :sorted, -> { order_by([:lft, :asc]) }

          hancock_cms_html_field :excerpt,   type: String, localize: Hancock::Catalog.configuration.localize, default: ""
          hancock_cms_html_field :content,   type: String, localize: Hancock::Catalog.configuration.localize, default: ""

          has_and_belongs_to_many :categories, class_name: "Hancock::Catalog::Category", inverse_of: nil

          if Hancock::Catalog.config.gallery_support
            embeds_many :item_images, cascade_callbacks: true, class_name: "Hancock::Catalog::ItemImage"
            alias :images :item_images
            accepts_nested_attributes_for :item_images, allow_destroy: true
          end

          has_and_belongs_to_many :related_items, :class_name => "Hancock::Catalog::Item", :inverse_of => :related_items

          # money_field :price, default_currency: nil
          field :price,     type: Money,    default: nil, localize: Hancock::Catalog.configuration.localize
        end
      end
    end
  end
end
