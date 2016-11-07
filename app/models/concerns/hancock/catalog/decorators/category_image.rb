module Hancock::Catalog::Decorators
  module CategoryImage
    extend ActiveSupport::Concern

    included do

      # def self.default_cache_keys
      #   []
      # end
      # 
      # # after_save :image_auto_rails_admin_jcrop
      # def image_auto_rails_admin_jcrop
      #   auto_rails_admin_jcrop(:image) # or nil for cancel autocrop
      # end
      #
      # # hancock_cms_attached_file(:image)
      # def image_styles
      #   Hancock::Catalog.configuration.category_images_image_styles
      # end
      #
      # def image_jcrop_options
      #   {}
      # end
      #
      # #############   rails_admin ##############
      # def self.rails_admin_add_fields
      #   {}
      # end
      #
      # def self.rails_admin_add_config(config)
      # end
      #
      # def admin_can_user_defined_actions
      #   [].freeze
      # end
      # def admin_cannot_user_defined_actions
      #   [].freeze
      # end
      # def manager_can_user_defined_actions
      #   [].freeze
      # end
      # def manager_cannot_user_defined_actions
      #   [].freeze
      # end
      # def rails_admin_user_defined_visible_actions
      #   [].freeze
      # end

    end

  end
end
