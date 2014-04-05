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
end
