# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    sequence(:short) {|i| "Topic ##{i}" }
    sequence(:long) {|i| "Statement ##{i}" }
  end
end
