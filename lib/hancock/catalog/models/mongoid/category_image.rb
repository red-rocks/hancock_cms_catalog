module Hancock::Catalog
  module Models
    module Mongoid
      module CategoryImage
        extend ActiveSupport::Concern

        included do
          embedded_in :category, class_name: "Hancock::Catalog::Category"

          def self.find(id)
            find_through(Hancock::Catalog::Category, 'category_images', id)
          end
        end
        
      end
    end
  end
end
