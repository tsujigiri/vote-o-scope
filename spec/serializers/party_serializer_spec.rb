require 'spec_helper'

describe PartySerializer do
  let(:question) { FactoryGirl.create(:question) }
  let(:answer) { FactoryGirl.create(:answer, question: question, answer: 'yes',
                                    reasoning: 'Because!') }
  let(:party) { FactoryGirl.create(:party, answers: [answer]) }

  it 'includes answers in the JSON' do
    json = PartySerializer.new(party).to_json
    expect(JSON.load(json).keys).to include('answers')
    expect(JSON.load(json)['answers']).to eq([{
      'id'          => answer.id,
      'party_id'    => party.id,
      'question_id' => question.id,
      'answer'      => 'yes',
      'reasoning'   => 'Because!'
    }])
  end
end
