require 'spec_helper'

describe 'answering a question' do
  before(:all) do
    DatabaseCleaner.strategy = :truncation
  end

  after(:all) do
    DatabaseCleaner.strategy = :transaction
  end

  let!(:party1) { FactoryGirl.create(:party, name: 'ABC') }
  let!(:party2) { FactoryGirl.create(:party, name: 'XYZ') }

  let!(:question1) { FactoryGirl.create(:question) }
  let!(:question2) { FactoryGirl.create(:question) }
  let!(:question3) { FactoryGirl.create(:question) }

  let!(:answer1) { FactoryGirl.create(:answer, party: party1, question: question1, answer: 'agree') }
  let!(:answer2) { FactoryGirl.create(:answer, party: party1, question: question2, answer: 'disagree') }
  let!(:answer3) { FactoryGirl.create(:answer, party: party1, question: question3, answer: 'neutral') }
  let!(:answer4) { FactoryGirl.create(:answer, party: party2, question: question1, answer: 'neutral') }
  let!(:answer5) { FactoryGirl.create(:answer, party: party2, question: question2, answer: 'disagree') }
  let!(:answer6) { FactoryGirl.create(:answer, party: party2, question: question3, answer: 'agree') }

  it 'loads the next one', js: true do
    visit answer_questions_path(question1)
    expect(page).to have_content(question1.short)
    find('a[data-answer="agree"]').click
    expect(page).to have_content(question2.short)
    find('a[data-answer="disagree"]').click
    expect(page).to have_content(question3.short)
    find('a[data-answer="neutral"]').click
    expect(page).to have_table 'vote-o-scope-top-list'
    expect(page).to have_table 'vote-o-scope-detailed-results'
    html = Nokogiri::HTML.parse(page.body)
    top_list = html.css('table#vote-o-scope-top-list').first
    table = top_list.css('tr').map {|tr| tr.css('td').map(&:text) }
    expect(table).to eq(
      [
        ['ABC', '', '100 %'],
        ['XYZ', '', '33 %'],
      ]
    )
  end
end
