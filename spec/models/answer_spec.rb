require 'spec_helper'

describe Answer do
  let(:answer) { FactoryGirl.create(:answer) }

  it 'contains an answer' do
    answer.update(answer: :agree)
    answer.reload
    expect(answer.answer).to be(:agree)
  end

  it 'raises UnknownEnumerableValue when value is invalid' do
    expect {
      answer.update(answer: :maybe)
    }.to raise_error(EnumSerializer::ValueInvalid)
  end

  it 'ensures only one answer per question-party combination' do
    party = FactoryGirl.create(:party)
    question = FactoryGirl.create(:question)
    expect {
      FactoryGirl.create(:answer, party: party, question: question)
      expect {
        FactoryGirl.create(:answer, party: party, question: question)
      }.to raise_error(ActiveRecord::RecordInvalid)
    }.to change(Answer, :count).by(1)
  end

  describe '#missing' do
    it 'returns a list of new answers that have not yet been created' do
      party1 = FactoryGirl.create(:party)
      party2 = FactoryGirl.create(:party)
      question1 = FactoryGirl.create(:question)
      question2 = FactoryGirl.create(:question)
      FactoryGirl.create(:answer, question: question1, party: party1)
      FactoryGirl.create(:answer, question: question2, party: party2)
      expect(Answer.missing.map {|a| [a.party_id, a.question_id] }).to match_array(
        [[party1.id,question2.id], [party2.id,question1.id]]
      )
    end
  end
end
