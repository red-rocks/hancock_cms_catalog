if defined?(Shrine)
  class Hancock::Catalog::ItemImageUploader < Shrine
  
    # include ::HancockShrine::UploaderBase
    include ::HancockShrine::Uploadable

  end
end