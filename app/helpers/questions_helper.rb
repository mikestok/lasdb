# encoding: UTF-8

##
# This is a place for helpers for the Question views to be put. They don't
# belong in the model, or the controller, and should not clutter up the
# view template.
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
    list.sort do |a, b|
      case
      when a.nil? && b.nil? then 0
      when a.nil?           then -1
      when b.nil?           then 1
      else a <=> b
      end
    end
  end

  # These helpers are used on the edit question form to manipulate the
  # answers.
  
  # in:
  #  * a form helper
  #  * the direction
  # 
  # Used in app/views/edit_answer_row.html.erb
  def move_answer_control(f, direction)
    answer = f.object
    image_link = case direction
                 when 'up'
                   make_icon_tag 'arrow2_n',
                     title: 'Move answer up'
                 when 'down'
                   make_icon_tag 'arrow2_s',
                     title: 'Move answer down'
                 else
                   raise "Unsupported value '#{direction}'"
                 end
    link_to image_link, {
      controller: :questions,
      id: answer.question.id,
      action: :move_answer,
      direction: direction,
      answer_id: answer.id,
    },
    {
      # The move answer control class is used to allow them to be hidden
      # when answer content is changed.  For the move to be safe the answer
      # needs to have been saved.
      class: 'move-answer-control',
      remote: true,
      method: :post,
    }
  end

  def delete_answer_control(f)
    answer = f.object
    link_to make_icon_tag('trash', title: 'Delete answer'), {
      controller: :questions,
      id: answer.question.id,
      action: :delete_answer,
      answer_id: answer.id,
    },
    {
      confirm: 'Are you sure?',
      remote: true,
      method: :post,
    }
  end

  def add_answer_control(f)
    question = f.object
    link_to make_icon_tag('add', title: 'Add an answer'), {
      controller: :questions,
      id: question.id,
      action: :add_answer,
    },
    {
      remote: true,
      method: :post,
    }
  end
end
