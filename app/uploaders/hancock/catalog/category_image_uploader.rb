if defined?(Shrine)
  class Hancock::Catalog::CategoryImageUploader < Shrine
  
    # include ::HancockShrine::UploaderBase
    include ::HancockShrine::Uploadable

  end
end