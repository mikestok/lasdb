class AddAnchoredToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :anchored, :boolean
  end
end
