# Active Admin Edn

EDN Export for [Active Admin]

[![Version][rubygems_badge]][rubygems]
[![Travis CI][travis_badge]][travis]
[![Quality][codeclimate_badge]][codeclimate]
[![Coverage][codecov_badge]][codecov]
[![Inch CI][inch_badge]][inch]

## Synopsis

This gem provides edn downloads for Active Admin resources.

## Usage

Add the following to your Gemfile. All resource index views will now include a link for download directly to edn.

```ruby
gem 'activeadmin-edn', '~>0.0.0'
```

For Active Admin 1.0 and above, you will also have to update config/initializers/active_admin.rb.  Update the download\_links setting to include edn:

```ruby
config.download_links = %i[csv xml json edn]
```

## Dependencies

This gem depends on [edn] to generate edn files.

## Examples

Here are a few quick examples of things you can easily tweak.

### Localize column headers

```ruby
# app/admin/posts.rb
ActiveAdmin.register Post do
  config.edn_builder.i18n_scope = [:active_record, :models, :posts]
end

## Testing

Running specs for this gem requires that you construct a rails application.

To execute the specs, navigate to the gem directory, run bundle install and run these to rake tasks:

### Rails 4.2

```text
bundle install --gemfile=gemfiles/rails_42.gemfile
```

```text
BUNDLE_GEMFILE=gemfiles/rails_42.gemfile bundle exec rake setup
```

```text
BUNDLE_GEMFILE=gemfiles/rails_42.gemfile bundle exec rake
```

### Rails 5.2

```text
bundle install --gemfile=gemfiles/rails_52.gemfile
```

```text
BUNDLE_GEMFILE=gemfiles/rails_52.gemfile bundle exec rake setup
```

```text
BUNDLE_GEMFILE=gemfiles/rails_52.gemfile bundle exec rake
```

### Rails 6.0

```text
bundle install --gemfile=gemfiles/rails_60.gemfile
```

```text
BUNDLE_GEMFILE=gemfiles/rails_60.gemfile bundle exec rake setup
```

```text
BUNDLE_GEMFILE=gemfiles/rails_60.gemfile bundle exec rake
```

[Active Admin]:https://www.activeadmin.info/
[activeadmin-axlsx]:https://github.com/randym/activeadmin-axlsx
[to_xls]:https://github.com/splendeo/to_xls
[spreadsheet]:https://github.com/zdavatz/spreadsheet

[rubygems_badge]: https://img.shields.io/gem/v/activeadmin-xls.svg
[rubygems]: https://rubygems.org/gems/activeadmin-xls
[travis_badge]: https://img.shields.io/travis/thambley/activeadmin-xls/master.svg
[travis]: https://travis-ci.org/thambley/activeadmin-xls
[codeclimate_badge]: https://api.codeclimate.com/v1/badges/e294712bac54d4520182/maintainability
[codeclimate]: https://codeclimate.com/github/thambley/activeadmin-xls/maintainability
[codecov_badge]: https://codecov.io/gh/thambley/activeadmin-xls/branch/master/graph/badge.svg
[codecov]: https://codecov.io/gh/thambley/activeadmin-xls
[inch_badge]: http://inch-ci.org/github/thambley/activeadmin-xls.svg?branch=master
[inch]: http://inch-ci.org/github/thambley/activeadmin-xls
