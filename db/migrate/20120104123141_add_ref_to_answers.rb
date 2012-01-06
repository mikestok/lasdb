class AddRefToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :ref, :string, :limit => 5
  end
end
