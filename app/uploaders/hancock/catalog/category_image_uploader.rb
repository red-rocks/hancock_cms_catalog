if defined?(Shrine)
  class Hancock::News::CategoryImageUploader < Shrine
  
    # include ::HancockShrine::UploaderBase
    include ::HancockShrine::Uploadable

  end
end