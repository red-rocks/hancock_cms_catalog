module ActionDispatch::Routing
  class Mapper
    def hancock_cms_catalog_routes(config = {})
      routes_config = {
        use_items_path: true,
        use_categories_path: true,
        use_catalog_path: true,
        catalog_path: '/',
        catalog_scope: '/catalog',
        classes: {
          items: :items,
          categories: :categories,
          catalog_controller: :categories
        },
        paths: {
          items: :items,
          categories: :categories
        },
        pagination: {
          items: true,
          categories: true,
          category_items: true
        },
        actions: {
          items: [:show],
          categories: [:show],
        }
      }
      routes_config.deep_merge!(config)

      generate_hancock_catalog_user_routes(routes_config)
      generate_hancock_catalog_cms_routes(routes_config)
    end


    private
    def generate_hancock_catalog_user_routes(routes_config)
      if !routes_config[:use_items_path] and !routes_config[:classes][:items].nil?
        resources routes_config[:classes][:items].to_sym, only: routes_config[:actions][:items], path: routes_config[:paths][:items] do
          get '(/page/:page)', action: :index, on: :collection, as: "" if routes_config[:pagination][:items]
        end
      end

      if !routes_config[:use_categories_path] and !routes_config[:classes][:categories].nil?
        resources routes_config[:classes][:categories].to_sym, only: routes_config[:actions][:categories], path: routes_config[:paths][:categories] do
          get '(/page/:page)', action: :index, on: :collection, as: "" if routes_config[:pagination][:categories]
          get 'items(/page/:page)', action: :items, on: :member, as: :items if routes_config[:pagination][:category_items]
        end
      end

      if !routes_config[:use_catalog_path] and !routes_config[:classes][:catalog_controller].nil?
        get "#{routes_config[:catalog_path]}" => "#{routes_config[:classes][:catalog_controller]}#index"
      end
    end

    def generate_hancock_catalog_cms_routes(routes_config)
      scope module: 'hancock' do
        scope routes_config[:catalog_scope], module: 'catalog' do
          if routes_config[:use_items_path] and !routes_config[:classes][:items].nil?
            resources routes_config[:classes][:items].to_sym, only: routes_config[:actions][:items], path: routes_config[:paths][:items], as: :hancock_catalog_items do
              get '(/page/:page)', action: :index, on: :collection, as: "" if routes_config[:pagination][:items]
            end
          end

          if routes_config[:use_categories_path] and !routes_config[:classes][:categories].nil?
            resources routes_config[:classes][:categories].to_sym, only: routes_config[:actions][:categories], path: routes_config[:paths][:categories], as: :hancock_catalog_categories do
              get '(/page/:page)', action: :index, on: :collection, as: "" if routes_config[:pagination][:categories]
              get 'items(/page/:page)', action: :items, on: :member, as: :items if routes_config[:pagination][:category_items]
            end
          end
          if routes_config[:use_catalog_path] and !routes_config[:classes][:catalog_controller].nil?
            get "#{routes_config[:catalog_path]}" => "#{routes_config[:classes][:catalog_controller]}#index", as: :hancock_catalog
          end
        end
      end
    end

  end
end
