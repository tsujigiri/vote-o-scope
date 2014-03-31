class PartySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :answers
end
