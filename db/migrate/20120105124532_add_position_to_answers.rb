class AddPositionToAnswers < ActiveRecord::Migration
  # http://guides.rubyonrails.org/migrations.html#using-models-in-your-migrations
  # has an explanation of why the definition of Question is necessary,
  # or at least desirable.
  class Quesstion < ActiveRecord::Base
  end

  def up
    add_column :answers, :position, :integer
    Question.all.each do |q|
      q.answers.sort_by{ |a| a.id }.each_with_index do |a, i|
        a.position = i + 1
        a.save
      end
    end
  end

  def down
    remove_column :answers, :position
  end
end
