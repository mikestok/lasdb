source 'http://rubygems.org'

gem 'rails', '3.0.7'
gem "jquery-rails"
gem "acts_as_tree_rails3"
gem "foreman"
gem "thin"


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
end

group :test do
  gem "mocha"
end
