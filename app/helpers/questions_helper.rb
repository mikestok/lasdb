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
      { :full_category => list[0].full_category,
        :questions => list,
      }
    end
  end
end
