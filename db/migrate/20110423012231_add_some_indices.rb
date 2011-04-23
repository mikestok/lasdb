class AddSomeIndices < ActiveRecord::Migration
  # Wholesale addition of indices to any column which
  # references another model's id.
  def self.up
    add_index :answers, :question_id
    add_index :categories, :parent_id
    add_index :questions, :category_id
  end

  def self.down
    remove_index :questions, :category_id
    remove_index :categories, :parent_id
    remove_index :answers, :question_id
  end
end
