module ApplicationHelper
  def button_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + button_to_function(name, "remove_fields(this)")
  end

  # Note to self:
  #
  # name = text of the link
  # f = a form 
  # association = the type of thing associated with the form (e.g. :answers
  # for a question form)
  def button_to_add_fields_to_list(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    button_to_function(name, %Q/add_fields_to_list(this, "#{association}", "#{escape_javascript(fields)}")/)
  end
end
