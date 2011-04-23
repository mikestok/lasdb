class PopulateQuestionCategories < ActiveRecord::Migration
  # This should be run when the Question model doesn't
  # have a 
  #
  # has_one :category
  #
  # so we can mess with the column category and the 
  # column for the category_id
  def self.up
    add_column :questions, :category_temp, :integer

    say_with_time "Generating Categories for Questions..." do
      Question.all.each do |q|
        if not q.category.blank?
          c = Category.find_or_create_by_name(q.category)
          id = c.id;
          if not q.subcategory.blank?
            sc = c.children.find_or_create_by_name(q.subcategory)
            id = sc.id;
          end
          q.category_temp = id
          q.save
        end
      end
    end

    rename_column :questions, :category_temp, :category_id
    remove_column :questions, :subcategory, :string
    remove_column :questions, :category, :string
  end

  def self.down
    add_column :questions, :category_name, :string
    add_column :questions, :subcategory, :string
    rename_column :questions, :category_id, :category_temp
    say_with_time "Regenerating Questions category / subcategory columns..." do
      Question.all.each do |q|
        if (c_id = q.category_temp) && (c = Category.find(c_id))
          if c.ancestors.empty?
            q.category_name = c.name
          else
            q.category_name = c.ancestors.first.name
            q.subcategory = c.name
          end
          q.save
        end
      end
    end
    rename_column :questions, :category_name, :category
    remove_column :questions, :category_temp
  end
end
