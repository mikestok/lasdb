class AddRefToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :ref, :text, :limit => 5
  end
end
