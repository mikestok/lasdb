class AddPositionToAnswers < ActiveRecord::Migration
  def up
    add_column :answers, :position, :integer
    Question.all.each do |q|
      q.answers.sort_by{ |a| a.id }.each_with_index do |a, i|
        a.position = i
        a.save
      end
    end
  end
  def down
    remove_column :answers, :position
  end
end
