require 'test_helper'

##
# Tests for Categories
class CategoryTest < ActiveSupport::TestCase
  test "sorts are stable" do
    # e is the expected result set and should be created in the
    # order we expect the array to arrive in after sorting
    e = []
    e << r1 = Category.create(name: "Apple")
    e << r1.children.create(name: "fritter") # r1_1
    e << r2 = Category.create(name: "apple")
    e << r2_1 = r2.children.create(name: "Fritter")
    e << r2_1.children.create(name: "with sauce") # r2_1_1
    e << r2_2 = r2.children.create(name: "fritter")
    e << r2_2_1 = r2_2.children.create(name: "with sauce")
    e << r2_2_1.children.create(name: "and fries") # r2_2_1_1
    e << Category.create(name: "Banana") # r3
    e << r4 = Category.create(name: "Chocolate")
    e << r4_1 = r4.children.create(name: "fudge")
    e << r4_1.children.create(name: "sundae") # r4_1_1
    assert_equal e, e.shuffle.sort
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

