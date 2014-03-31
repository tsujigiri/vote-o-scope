class Party < ActiveRecord::Base
  has_many :answers
  validates :name, presence: true
end
