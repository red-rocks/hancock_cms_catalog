module ActionDispatch::Routing
  class Mapper
    def hancock_cms_catalog_routes(config = {})
      routes_config = {
        use_items_path: true,
        use_categories_path: true,
        use_catalog_path: true,
        catalog_path: '/',
        catalog_scope: '/catalog',
        resources: {
          items: {
            only: :show
          },
          categories: {
            only: :show
          },
        },
        pagination: {
          items: true,
          categories: true,
          category_items: true
        },
        catalog_controller: :categories
      }
      routes_config.deep_merge!(config)

      generate_hancock_catalog_user_routes(routes_config)
      generate_hancock_catalog_cms_routes(routes_config)
    end


    private
    def generate_hancock_catalog_user_routes(routes_config)
      if !routes_config[:use_items_path] and routes_config[:resources][:items] != false
        resources :items, routes_config[:resources][:items] || {} do
          get '(/page/:page)', action: :index, on: :collection, as: "" if routes_config[:pagination][:items]
        end
      end

      if !routes_config[:use_categories_path] and routes_config[:classes][:categories] != false
        resources :categories, routes_config[:resources][:categories] || {} do
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
          if routes_config[:use_items_path] and routes_config[:resources][:items] != false
            resources :items, routes_config[:resources][:items] || {} do
              get '(/page/:page)', action: :index, on: :collection, as: "" if routes_config[:pagination][:items]
            end
          end

          if routes_config[:use_categories_path] and routes_config[:resources][:categories] != false
            resources :categories, routes_config[:resources][:categories] || {} do
              get '(/page/:page)', action: :index, on: :collection, as: "" if routes_config[:pagination][:categories]
              get 'items(/page/:page)', action: :items, on: :member, as: :items if routes_config[:pagination][:category_items]
            end
          end
          if routes_config[:use_catalog_path] and !routes_config[:catalog_controller].nil?
            get "#{routes_config[:catalog_path]}" => "#{routes_config[:catalog_controller]}#index", as: routes_config[:catalog_path]
          end
        end
      end
    end

  end
end
