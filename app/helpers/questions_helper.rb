# encoding: UTF-8

module QuestionsHelper
  # in: a list of questions
  # out: a list of hashes containing the list of questions
  #      for each category and the full category name.
  #
  # Used to group question search result sets into categories
  # for display.
  def categorised_questions(questions)
    c = Hash.new { |h, k| h[k] = [] }
    questions.each do |q|
      c[q.full_category.downcase] <<= q
    end
    c.values_at(* c.keys.map(&:downcase)).map do |list|
      { :full_category => full_category(list[0]),
        :questions => list,
      }
    end
  end
 
  # in: a question 
  #     optional string to join elements with
  # out: a string
  #
  # Generate a full category for a question in a form 
  # useful for printing.
  def full_category(question, join_with = " ⇒ ")
    return "" if question.category.nil?
    question.category.with_ancestors.map(&:name).join(join_with)
  end
end
