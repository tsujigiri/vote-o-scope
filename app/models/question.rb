class Question < ActiveRecord::Base
  validates :short, presence: true
  validates :long, presence: true
  acts_as_list
end
