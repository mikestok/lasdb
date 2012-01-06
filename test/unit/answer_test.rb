require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end




# == Schema Information
#
# Table name: answers
#
#  id          :integer         not null, primary key
#  question_id :integer
#  text        :text
#  correct     :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  ref         :string(5)
#  position    :integer
#  anchored    :boolean
#

