class Answer < ActiveRecord::Base
  validates :party, presence: true
  validates :question, presence: true
  validates :answer, presence: true

  belongs_to :party
  belongs_to :question

  ANSWERS = [:not_answered, :yes, :no]
  serialize :answer, EnumSerializer.new(ANSWERS)
end
