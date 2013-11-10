##
# Controller for the "home" page. There is no Home class, this is used
# by +config/routes.rb+ which includes:
#
#     get "home/index"
#
#     root to: "home#index"
#
class HomeController < ApplicationController

  ##
  # The index method is here so that we can render the template in
  # +app/views/index.html.erb+ which doesn’t use any parameters.
  def index
  end

end
