class CategoriesController < ApplicationController
  def index
    @root_categories = Category.where(:parent_id => nil)
  end
end
