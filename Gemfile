source 'http://rubygems.org'

ruby '2.0.0'

gem 'rails', '~> 3.2'
gem "jquery-rails"
gem "acts_as_tree_rails3"
gem "acts_as_list"
gem "foreman"
gem "thin"

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :production do
  gem "pg"
  gem "newrelic_rpm"
  # gem "rack-ssl", :require => "rack/ssl"
end

group :development, :test do
  gem "sqlite3"
end

group :development do
  gem "nifty-generators"
  # gem "taps"
  gem "annotate"
  # gem "ruby-debug" # This doesn't seem to work with 1.9.x or 2.x.x
  gem "rails-erd"
end

group :test do
  gem "mocha", :require => false
end
