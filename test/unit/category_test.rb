require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "sorts are stable" do
    # e is the expected result set and should be created in the
    # order we expect the array to arrive in after sorting
    e = []
    e << r1 = Category.create(:name => "Apple")
    e << r1_1 = r1.children.create(:name => "fritter")
    e << r2 = Category.create(:name => "apple")
    e << r2_1 = r2.children.create(:name => "Fritter")
    e << r2_1_1 = r2_1.children.create(:name => "with sauce")
    e << r2_2 = r2.children.create(:name => "fritter")
    e << r2_2_1 = r2_2.children.create(:name => "with sauce")
    e << r2_2_1_1 = r2_2_1.children.create(:name => "and fries")
    e << r3 = Category.create(:name => "Banana")
    e << r4 = Category.create(:name => "Chocolate")
    e << r4_1 = r4.children.create(:name => "fudge")
    e << r4_1_1 = r4_1.children.create(:name => "sundae")
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

