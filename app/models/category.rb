class Category < ActiveRecord::Base
  acts_as_tree
  has_many :questions

  # Generates a list of ancestors + this category from the 
  # root to the category.
  def with_ancestors
    ([self] + ancestors).reverse
  end
end
