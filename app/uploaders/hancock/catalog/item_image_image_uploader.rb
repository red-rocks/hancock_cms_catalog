if defined?(Shrine)
  class Hancock::News::NewsImageImageUploader < Shrine
  
    include ::HancockShrine::BaseUploader
    # include ::HancockShrine::Uploadable

  end
end