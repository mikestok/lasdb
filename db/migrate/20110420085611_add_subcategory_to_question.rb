class AddSubcategoryToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :subcategory, :string
  end

  def self.down
    remove_column :questions, :subcategory
  end
end
