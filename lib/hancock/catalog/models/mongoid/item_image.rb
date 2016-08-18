module Hancock::Catalog
  module Models
    module Mongoid
      module ItemImage
        extend ActiveSupport::Concern

        included do
          embedded_in :item, class_name: "Hancock::Catalog::Item"
        end

        include ::Mongoid::EmbeddedFindable
        module ClassMethods
          def find(id)
            find_through(Hancock::Catalog::Item, 'item_images', id)
          end
        end
      end
    end
  end
end
