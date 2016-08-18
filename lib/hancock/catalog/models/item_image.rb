module Hancock::Catalog
  module Models
    module ItemImage
      extend ActiveSupport::Concern
      # include Hancock::Model
      # include Hancock::Enableable

      include Hancock::Catalog.orm_specific('ItemImage')

      included do
      end

      def image_styles
        Hancock::Catalog.configuration.item_images_image_styles
      end
    end
  end
end
