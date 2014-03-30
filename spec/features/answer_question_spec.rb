require 'spec_helper'

describe 'answering a question' do
  let!(:question1) { FactoryGirl.create(:question) }
  let!(:question2) { FactoryGirl.create(:question) }

  it 'loads the next one', js: true do
    visit answer_questions_path(question1)
    click_link 'Yes'
    expect(page).to have_content(question2.short)
  end
end
