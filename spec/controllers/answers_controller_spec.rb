require 'spec_helper'

describe AnswersController do
  render_views

  let!(:answer) { FactoryGirl.create(:answer) }

  context 'as an admin' do
    let(:admin) { FactoryGirl.create(:user) }

    before do
      sign_in admin
    end

    describe 'GET #index' do

      it 'loads all the answers' do
        get :index
        expect(response).to be_success
        expect(assigns[:answers]).to eq(Answer.all)
      end
    end

    describe 'GET #edit' do
      it "loads a answer's form" do
        get :edit, id: answer.id
        expect(response).to be_success
        expect(assigns[:answer]).to eq(answer)
      end
    end

    describe 'GET #new' do
      it "loads a answer's form" do
        get :new
        expect(response).to be_success
        expect(assigns[:answer]).to be_new_record
      end
    end

    describe 'PUT #update' do
      it 'updates a answer' do
        post :update, id: answer.id, answer: { answer: :yes }
        answer.reload
        expect(answer.answer).to eq(:yes)
        expect(response).to redirect_to(answers_path)
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes a answer' do
        expect {
          delete :destroy, id: answer.id
        }.to change(Answer, :count).by(-1)
        expect(response).to redirect_to(answers_path)
      end
    end
  end
end
