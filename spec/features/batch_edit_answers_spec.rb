require 'spec_helper'

feature 'batch-edit answers' do
  let!(:question1) { FactoryGirl.create(:question) }
  let!(:question2) { FactoryGirl.create(:question) }
  let!(:party1) { FactoryGirl.create(:party) }
  let!(:party2) { FactoryGirl.create(:party) }
  let!(:answer_1_1) do
    FactoryGirl.create(:answer, party: party1, question: question1,
                       answer: :disagree)
  end

  before do
    web_sign_in
  end

  scenario 'all question-party permutations are answerable' do
    visit '/answers'
    choose(by_id(party1, question1, 'answer_agree'))
    choose(by_id(party1, question2, 'answer_neutral'))
    choose(by_id(party2, question1, 'answer_disagree'))
    choose(by_id(party2, question2, 'answer_agree'))
    fill_in(by_id(party1, question1, 'reasoning'), with: 'Because!')
    fill_in(by_id(party1, question2, 'reasoning'), with: 'We just don\'t care.')
    expect {
      click_on('Submit')
    }.to change(Answer, :count).by(3)
    expect(answer(party1, question1).answer).to eq(:agree)
    expect(answer(party1, question1).reasoning).to eq('Because!')
    expect(answer(party1, question2).answer).to eq(:neutral)
    expect(answer(party1, question2).reasoning).to eq('We just don\'t care.')
    expect(answer(party2, question1).answer).to eq(:disagree)
    expect(answer(party2, question2).answer).to eq(:agree)
    expect(find(by_id(party1, question1, 'answer_agree', true))).to be_checked
    expect(find(by_id(party1, question2, 'answer_neutral', true))).to be_checked
    expect(find(by_id(party2, question1, 'answer_disagree', true))).to be_checked
    expect(find(by_id(party2, question2, 'answer_agree', true))).to be_checked
    expect(find(by_id(party1, question1, 'reasoning', true)).text).to eq('Because!')
    expect(find(by_id(party1, question2, 'reasoning', true)).text).to eq('We just don\'t care.')
  end

  def answer(party, question)
    Answer.where(party_id: party.id, question_id: question.id).first
  end

  def by_id(party, question, suffix, with_hash=false)
    str = ''
    str << '#' if with_hash
    str << "answers_party_#{party.id}_question_#{question.id}_#{suffix}"
    str
  end
end
