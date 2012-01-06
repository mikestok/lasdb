source 'http://rubygems.org'

gem 'rails'
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
  gem "rack-ssl", :require => "rack/ssl"
end

group :development, :test do
  gem "sqlite3-ruby", :require => "sqlite3"
end
  
group :development do
  gem "nifty-generators"
  gem "taps"
  gem "heroku"
  gem "annotate"
end

group :test do
  gem "mocha"
end
