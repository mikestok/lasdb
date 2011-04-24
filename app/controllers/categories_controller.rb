class CategoriesController < ApplicationController
  def index
    @root_categories = Category.where(:parent_id => nil)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    name = params[:category][:name]
    parent_id = params[:category][:parent_id]

    if parent_id.blank?
      @category = Category.create(:name => name)
    else
      @category = Category.find(parent_id).children.create(:name => name)
    end

    if @category.save
      redirect_to @category, :notice => "Successfully created category."
    else
      render :action => 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to @category, :notice  => "Successfully updated category."
    else
      render :action => 'edit'
    end
  end

  # TODO - Think about:
  #  * Should we allow users to delete a non-leaf category?
  #    * If so, does it destroy all the sub-categories of it?
  #  * When we destroy a category then what happens to its 
  #    questions?  
  #
  # def destroy
  #   @category = Category.find(params[:id])
  #   @category.destroy
  #   redirect_to categories_url, :notice => "Successfully destroyed category."
  # end
end
