module Hancock::Catalog
  class CategoriesController < ApplicationController
    include Hancock::Catalog::Controllers::Categories

    include Hancock::Catalog::Decorators::Categories
  end
end
