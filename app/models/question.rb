class Question < ActiveRecord::Base
  attr_accessible :prompt, :answers, :answers_attributes
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers,
    :reject_if => lambda { |a| a[:text].blank? },
    :allow_destroy => true
  validates_presence_of :prompt, :answers
end
