class FixAnswerCorrectColumnName < ActiveRecord::Migration
  def self.up
    rename_column :answers, :correct?, :correct
  end

  def self.down
    rename_column :answers, :correct, :correct?
  end
end
