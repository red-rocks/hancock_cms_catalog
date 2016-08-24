# HancockCMSCatalog

Item Catalog for [HancockCMS](https://github.com/red-rocks/hancock_cms). Items, Categories, embedded image galleries.

### Remaded from [EnjoyCMSCatalog](https://github.com/red-rocks/enjoy_cms_catalog)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hancock_cms_catalog'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hancock_cms_catalog

## Usage

Add in config/routes.rb

```ruby
  hancock_cms_catalog_routes
```

Then execute

    $ rails g hancock:catalog:config

and now you can edit config/initializers/hancock_catalog.rb

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/red-rocks/hancock_cms_catalog.

## TODO

  * Do it more flexible.
  * Documentation fixes.
  * More configs  (routes, paginations, views....)
  * Find and fix bugs. I am sure, bugs are here.
  * Add Search

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
