class Answer < ActiveRecord::Base
  belongs_to :question
  acts_as_list :scope => :question

  validates_format_of :ref,
    :with => /\A[A-Za-z0-9]{1,5}\Z/,
    :allow_blank => true
  validates_uniqueness_of :ref,
    :scope => :question_id,
    :allow_blank => true
end




# == Schema Information
#
# Table name: answers
#
#  id          :integer         not null, primary key
#  question_id :integer
#  text        :text
#  correct     :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  ref         :string(5)
#  position    :integer
#  anchored    :boolean
#

