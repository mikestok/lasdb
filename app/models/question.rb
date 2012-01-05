class Question < ActiveRecord::Base
  attr_accessible :prompt,
    :category_id,
    :answers, :answers_attributes
  belongs_to :category
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers,
    :reject_if => lambda { |a| a[:text].blank? },
    :allow_destroy => true
  validates_presence_of :prompt, :answers

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
  def answer_list
    tags = tag_list
    res = RefResolver.new(answers.map(&:ref), tags)

    answers.each.collect do |a|
      OpenStruct.new({
        :tag     => tags.shift,
        :text    => res.resolve_refs(a.text),
        :correct => a.correct,
      })
    end
  end

  private

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
