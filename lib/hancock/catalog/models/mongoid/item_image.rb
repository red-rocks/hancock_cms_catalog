module Hancock::Catalog
  module Models
    module Mongoid
      module ItemImage
        extend ActiveSupport::Concern

        included do
          embedded_in :item, class_name: "Hancock::Catalog::Item"

          def self.find(id)
            find_through(Hancock::Catalog::Item, 'item_images', id)
          end
        end
        
      end
    end
  end
end
