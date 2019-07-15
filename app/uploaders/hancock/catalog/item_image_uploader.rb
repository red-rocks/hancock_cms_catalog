if defined?(Shrine)
  class Hancock::News::NewsImageUploader < Shrine
  
    # include ::HancockShrine::UploaderBase
    include ::HancockShrine::Uploadable

  end
end