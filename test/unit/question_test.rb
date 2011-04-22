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
