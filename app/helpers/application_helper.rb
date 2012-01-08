module ApplicationHelper
  # in:
  #  * a form helper
  #  * the direction
  # 
  # Used in app/views/edit_answer_row.html.erb
  def move_answer_control(f, direction)
    answer = f.object
    link_to direction.capitalize, {
      :controller => :questions,
      :id         => answer.question.id,
      :action     => :move_answer,
      :direction  => direction,
      :answer_id  => answer.id,
    },
    { 
      :remote => true,
      :method => :post,
    }
  end

  def delete_answer_control(f, label)
    answer = f.object
    link_to label.capitalize, {
      :controller => :questions,
      :id         => answer.question.id,
      :action     => :delete_answer,
      :answer_id  => answer.id,
    },
    { 
      :confirm => "Are you sure?",
      :remote  => true,
      :method  => :post,
    }
  end

  def add_answer_control(f, label)
    question = f.object
    link_to label.capitalize, {
      :controller => :questions,
      :id         => question.id,
      :action     => :add_answer,
    },
    { 
      :remote => true,
      :method => :post,
    }
  end

end
