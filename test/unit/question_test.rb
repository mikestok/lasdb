require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  def setup
    @valid_q_params = {
      :prompt => 'This is a valid question because:',
      :answers_attributes => [
        {
          :text => 'It has a prompt',
          :correct => false,
        },
        {
          :text => 'It has an answer',
          :correct => false,
        },
        {
          :text => 'Both of the above',
          :correct => true,
        }
      ],
    }
  end

  def test_should_be_valid
    assert Question.new(@valid_q_params).valid?
  end
end

# == Schema Information
#
# Table name: questions
#
#  id          :integer         primary key
#  prompt      :text
#  created_at  :timestamp
#  updated_at  :timestamp
#  category_id :integer
#

