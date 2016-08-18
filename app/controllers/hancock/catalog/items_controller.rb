module Hancock::Catalog
  class ItemsController < ApplicationController
    include Hancock::Catalog::Controllers::Items

    include Hancock::Catalog::Decorators::Items
  end
end
