class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :party_id, :question_id, :answer, :reasoning
end
