require 'spec_helper'

describe 'answering a question' do
  before(:all) do
    DatabaseCleaner.strategy = :truncation
  end

  after(:all) do
    DatabaseCleaner.strategy = :transaction
  end

  let!(:question1) { FactoryGirl.create(:question) }
  let!(:question2) { FactoryGirl.create(:question) }
  let!(:question3) { FactoryGirl.create(:question) }

  it 'loads the next one', js: true do
    visit answer_questions_path(question1)
    expect(page).to have_content(question1.short)
    click_link 'agree'
    expect(page).to have_content(question2.short)
    click_link 'disagree'
    expect(page).to have_content(question3.short)
    click_link 'neutral'
    html = Nokogiri::HTML.parse(page.body)
    expect(html.css('table').size).to be(2)
  end
end
