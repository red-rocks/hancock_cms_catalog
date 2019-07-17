if defined?(Shrine)
  class Hancock::Catalog::ItemImageImageUploader < Shrine
  
    include ::HancockShrine::BaseUploader
    # include ::HancockShrine::Uploadable

  end
end