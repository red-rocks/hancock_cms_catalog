module Hancock::Catalog
  module Admin
    module CategoryImage
      def self.config(nav_label = nil, fields = {})
        if Hancock::Catalog.config.gallery_support
          if Hancock::Catalog.mongoid?
            if block_given?
              Hancock::Gallery::Admin::EmbeddedImage.config(fields) do |config|
                yield config
              end
            else
              Hancock::Gallery::Admin::EmbeddedImage.config(fields)
            end

          else
            nav_label ||= I18n.t('hancock.catalog')
            if block_given?
              Hancock::Gallery::Admin::Image.config(nav_label, fields) do |config|
                yield config
              end
            else
              Hancock::Gallery::Admin::Image.config(nav_label,fields)
            end
          end #if Hancock::Catalog.mongoid?
        end #if Hancock::Catalog.config.gallery_support

      end #def self.config(fields = {})

    end #module CategoryImage
  end #module Admin
end #module Hancock::Catalog
