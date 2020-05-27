if defined?(Shrine)
  class Hancock::Catalog::CategoryImageImageUploader < Shrine
  
    # include ::HancockShrine::UploaderBase
    include ::HancockShrine::Uploadable

  end
end