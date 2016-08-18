Hancock.rails_admin_configure do |config|
  config.action_visible_for :nested_set, 'Hancock::Catalog::Item'
  config.action_visible_for :nested_set, 'Hancock::Catalog::Category'

  if Hancock::Catalog.active_record?
    config.action_visible_for :nested_set, 'Hancock::Catalog::ItemImage'
    config.action_visible_for :nested_set, 'Hancock::Catalog::CategoryImage'
  elsif Hancock::Catalog.mongoid?
    config.action_visible_for :sort_embedded, 'Hancock::Catalog::Item'
    config.action_visible_for :sort_embedded, 'Hancock::Catalog::Category'
  end

  if defined?(RailsAdminComments)
    config.action_visible_for :comments, 'Hancock::Catalog::Item'
    config.action_visible_for :comments, 'Hancock::Catalog::Category'
    config.action_visible_for :model_comments, 'Hancock::Catalog::Item'
    config.action_visible_for :model_comments, 'Hancock::Catalog::Category'
    if Hancock::Catalog.active_record?
      config.action_visible_for :comments, 'Hancock::Catalog::ItemImage'
      config.action_visible_for :comments, 'Hancock::Catalog::CategoryImage'
      config.action_visible_for :model_comments, 'Hancock::Catalog::ItemImage'
      config.action_visible_for :model_comments, 'Hancock::Catalog::CategoryImage'
    end
  end

  if defined?(RailsAdminMultipleFileUpload)
    if Hancock::Catalog.mongoid?
      config.action_visible_for :multiple_file_upload, 'Hancock::Catalog::Item'
      config.action_visible_for :multiple_file_upload, 'Hancock::Catalog::Category'
    end
  end
end
