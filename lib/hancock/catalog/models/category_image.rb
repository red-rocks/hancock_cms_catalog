module Hancock::Catalog
  module Models
    module CategoryImage
      extend ActiveSupport::Concern
      # include Hancock::Model
      # include Hancock::Enableable

      include Hancock::Catalog.orm_specific('CategoryImage')

      included do
      end

      def image_styles
        Hancock::Catalog.configuration.category_images_image_styles
      end
    end
  end
end
