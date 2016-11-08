module Hancock::Catalog
  module Admin
    module CategoryImage
      def self.config(nav_label = nil, fields = {})
        if nav_label.is_a?(Hash)
          nav_label, fields = nav_label[:nav_label], nav_label
        elsif nav_label.is_a?(Array)
          nav_label, fields = nil, nav_label
        end
        nav_label ||= I18n.t('hancock.catalog')

        if Hancock::Catalog.config.gallery_support
          if Hancock::Catalog.mongoid?
            if block_given?
              Hancock::Gallery::Admin::EmbeddedImage.config(nav_label, fields) do |config|
                yield config
              end
            else
              Hancock::Gallery::Admin::EmbeddedImage.config(nav_label, fields)
            end

          else
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
