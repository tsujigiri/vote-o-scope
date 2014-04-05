class Answer < ActiveRecord::Base
  belongs_to :party
  belongs_to :question

  validates :party, presence: true
  validates :question, presence: true
  validates :answer, presence: true

  ANSWERS = [:agree, :disagree, :neutral]
  serialize :answer, EnumSerializer.new(ANSWERS)
end
