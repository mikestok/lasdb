# This models the Question, which is the main component of the database.
class Question < ActiveRecord::Base
  attr_accessible :prompt,
    :category_id,
    :answers, :answers_attributes
  belongs_to :category
  has_many :answers, dependent: :destroy, order: "position"
  accepts_nested_attributes_for :answers,
    reject_if: -> answer { answer[:text].blank? },
    allow_destroy: true
  validates_presence_of :prompt

  require 'ref_resolver'

  ##
  # Finds the most recent updated_at for the question and
  # any of its answers.
  def changed_at
    ([updated_at] + answers.map(&:updated_at)).max
  end

  ##
  # Generate an array containing the names of the categories
  # of this question and all the category's ancestors.
  def category_path
    category.nil? ? [] : category.with_ancestors.map(&:name)
  end

  ##
  # Generates the full category name for this Question
  def full_category_name
    category.nil? ?  "" : category.full_name
  end

  ##
  # Generates a list of displayable answers for this Question
  # whose order is possibly shuffled.
  #
  #
  # TODO Maybe create a DisplayableAnswer class.
  def answer_list(opts={})
    list = opts[:shuffled] ? shuffled_answers : answers

    tags = tag_list
    res = RefResolver.new(list.map(&:ref), tags)

    list.each.map do |a|
      OpenStruct.new({
        tag:         tags.shift,
        text:        res.resolve_refs(a.text),
        explanation: a.explanation,
        correct:     a.correct,
      })
    end
  end

  private

  ##
  # This is used to shuffle the Answers to a Question, and it unserstands
  # about “anchored” answers. This means that we can safely shuffle a
  # list of Answers which contain “All of the above” as the last answer.
  def shuffled_answers
    shufflable_indices = []
    answers.each_with_index do |a, i|
      shufflable_indices << i unless a.anchored?
    end

    shuffled = answers.dup
    shufflable_indices.zip(shufflable_indices.shuffle).each do |pair|
      shuffled[pair[0]] = answers[pair[1]]
    end

    shuffled
  end

  ##
  # Generates a list of tags the right length for the answers to this Question.
  #
  # TODO: Are Tags a recognised class? I think so.
  def tag_list
    return [] if answers.size.zero?

    tags = ['a']
    (answers.size - 1).times { tags << tags.last.succ }

    tags
  end

end

# == Schema Information
#
# Table name: questions
#
#  id          :integer         primary key
#  prompt      :text
#  created_at  :timestamp
#  updated_at  :timestamp
#  category_id :integer
#

