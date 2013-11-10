# encoding: utf-8

##
# The Questions can be categorised, and the Categories are hierarchical.
#
# TODO: Decide if we want tagging or categories; tagging is more flexible.
class Category < ActiveRecord::Base
  acts_as_tree
  has_many :questions
  validates_presence_of :name

  ##
  # Generates a list of ancestors + this category from the 
  # root to the category.
  def with_ancestors
    ([self] + ancestors).reverse
  end

  ##
  # Generates the full name of this category
  def full_name(join_with=" ⇒ ")
    with_ancestors.map(&:name).join(join_with)
  end

  ##
  # This allows us to sort Categories.
  #
  # We sort categories in dictionary order on their
  # full list of names from root to category.
  def <=>(other)
    with_ancestors.zip(other.with_ancestors) do |a, b|
      # was one list shorter than the other?
      return -1 if a.nil?
      return 1 if b.nil?
      c = (a.name.downcase <=> b.name.downcase).nonzero? ||
          (a.name <=> b.name).nonzero?
      return c if c
    end
    # if we get all the way to the end of the list of names
    # then use the id as a tie breaker
    id <=> other.id
  end
end

# == Schema Information
#
# Table name: categories
#
#  id         :integer         primary key
#  name       :string(255)
#  parent_id  :integer
#  created_at :timestamp
#  updated_at :timestamp
#

