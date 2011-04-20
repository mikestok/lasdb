module QuestionsHelper
  # Generates a human readable combination of category and
  # subcategory
  def full_category(q)
    full_category = q.category
    if not q.subcategory.blank?
      full_category += " (#{q.subcategory})"
    end
    return full_category
  end
end
