# encoding: UTF-8

module QuestionsHelper
  # in: a list of questions
  # out: a list of lists of questions
  #
  # Used to group question search result sets into categories
  # for display.
  #
  # The outer list is sorted by category (with nils bubbled to 
  # the top for uncategorised questions).
  #
  # The inner lists are sorted by question.id so that they have
  # a stable and defined order.
  def sorted_grouped_questions(questions)
    grouped = questions.group_by { |q| q.category }
    grouped.values.each { |a| a.sort_by!(&:id) }
    sorted_keys = sort_categories_with_nils(grouped.keys)
    grouped.values_at(*sorted_keys)
  end

  # in: list of categories, possibly containing (a) nil
  # out: sorted list of categories with nil bubbled to the top
  #
  # Utility method to let us deal with uncategorised questions
  def sort_categories_with_nils(list)
    list.sort { |a, b|
      case
      when a.nil? && b.nil? then 0
      when a.nil?           then -1
      when b.nil?           then 1
      else a <=> b
      end
    }
  end
end
