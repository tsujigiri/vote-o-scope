require 'spec_helper'

describe AnswersController do
  render_views

  let(:party) { FactoryGirl.create(:party) }
  let(:question) { FactoryGirl.create(:question) }
  let!(:answer) { FactoryGirl.create(:answer, party: party, question: question) }

  context 'as an admin' do
    let(:admin) { FactoryGirl.create(:user) }

    before do
      sign_in admin
    end

    describe 'GET #index' do
      it 'loads all the answers' do
        get :index
        expect(response).to be_success
        expect(assigns[:answers]).to eq({ [party.id, question.id] => answer })
      end

      it 'renders json' do
        get :index, format: :json
        expect(response).to be_success
        expect(JSON.load(response.body)).to match_array([JSON.load(answer.to_json)])
      end
    end

    describe 'PUT #update' do
      it 'updates a answer' do
        post :update, id: answer.id, answers: {
          "party_#{party.id}_question_#{question.id}" =>
            { answer: :agree, party_id: party.id, question_id: question.id }
        }
        answer.reload
        expect(answer.answer).to eq(:agree)
        expect(response).to redirect_to(answers_path)
      end
    end
  end
end
