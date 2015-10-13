source 'http://rubygems.org'
ruby '1.9.3'

gem 'rails', '~> 3.1'
gem "jquery-rails"
gem "acts_as_tree_rails3"
gem "acts_as_list"
gem "foreman"
gem "thin"
gem "rake-compiler"

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :production, :development do
  gem "pg"
  gem "rack-ssl", :require => "rack/ssl"
end

group :development, :test do
  gem "sqlite3-ruby", :require => "sqlite3"
end

group :development do
  gem "nifty-generators"
  gem "taps"
  gem "annotate"
  gem "ruby-debug19"
end

group :test do
  gem "mocha", :require => false
end
