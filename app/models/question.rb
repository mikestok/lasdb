# encoding: UTF-8

class Question < ActiveRecord::Base
  attr_accessible :prompt,
    :answers, :answers_attributes
  belongs_to :category
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers,
    :reject_if => lambda { |a| a[:text].blank? },
    :allow_destroy => true
  validates_presence_of :prompt, :answers

  # Finds the most recent updated_at for the question and
  # any of its answers.
  def changed_at
    ([updated_at] + answers.map(&:updated_at)).max
  end

  # Generates a human readable category
  def full_category
    return '' if category.blank?
    category.with_ancestors.map(&:name).join(" ⇒ ");
  end
end
