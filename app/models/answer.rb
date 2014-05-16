class Answer < ActiveRecord::Base
  belongs_to :party
  belongs_to :question

  validates :party, presence: true
  validates :question, presence: true
  validates_uniqueness_of :question, scope: :party
  validates :answer, presence: true

  ANSWERS = [:agree, :disagree, :neutral]
  serialize :answer, EnumSerializer.new(ANSWERS)

  def self.all_with_missing
    answers = []
    Party.pluck(:id).each do |party_id|
      Question.pluck(:id).each do |question_id|
        answer = Answer.find_or_initialize_by(party_id: party_id, question_id: question_id)
        answers << answer
      end
    end
    answers
  end

  def self.missing
    all_with_missing.select {|a| a.new_record? }
  end
end
