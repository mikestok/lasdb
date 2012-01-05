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
    tag_for = ref_to_tag(tags)

    answers.each.collect do |a|
      text = translate_refs(a.text, tag_for)

      OpenStruct.new({
        :tag     => tags.shift,
        :text    => text,
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

  # in: tag list
  # out: hash mapping question's refs to tag names
  def ref_to_tag(tag_list)
    map = {}
    answers.each_with_index do |a, i|
      if a.ref
        map[a.ref] = tag_list[i]
      end
    end

    return map
  end

  def translate_refs(text, map)
    result = text.dup
    map.each_pair do |ref, tag|
      result.gsub!(/{{#{ref}}}/, tag)
    end

    return result
  end
end
