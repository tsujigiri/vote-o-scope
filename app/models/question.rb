class Question < ActiveRecord::Base
  validates :short, presence: true
  validates :long, presence: true
end
