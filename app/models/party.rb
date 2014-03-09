class Party < ActiveRecord::Base
  validates :name, presence: true
end
