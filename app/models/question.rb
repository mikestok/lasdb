class Question < ActiveRecord::Base
  attr_accessible :prompt,
    :category_id,
    :answers, :answers_attributes
  belongs_to :category
  has_many :answers, :dependent => :destroy, :order => "position"
  accepts_nested_attributes_for :answers,
    :reject_if => lambda { |a| a[:text].blank? },
    :allow_destroy => true
  validates_presence_of :prompt

  require 'ref_resolver'

  # Finds the most recent updated_at for the question and
  # any of its answers.
  def changed_at
    ([updated_at] + answers.map(&:updated_at)).max
  end

  # in: nothing
  # out: an array containing the names of the categories
  #      of this question and all the category's ancestors.
  def category_path
    case
    when category.nil? then []
    else category.with_ancestors.map(&:name)
    end
  end

  def full_category_name
    case 
    when category.nil? then ""
    else category.full_name
    end
  end

  require "ostruct"

  # in:
  # out:
  def answer_list(opts={})
    list = opts[:shuffled] ? shuffled_answers : answers

    tags = tag_list
    res = RefResolver.new(list.map(&:ref), tags)

    list.each.collect do |a|
      OpenStruct.new({
        :tag     => tags.shift,
        :text    => res.resolve_refs(a.text),
        :correct => a.correct,
      })
    end
  end

  private

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

  # in: nothing
  # out: list ot tags the right length for this questions answers
  def tag_list
    tags = []
    tag = 'a'
    answers.size.times do
      tags << tag
      tag = tag.succ
    end
    return tags
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

