require 'spec_helper'

describe QuestionsController do
  render_views

  let!(:question) { FactoryGirl.create(:question) }

  context 'as an admin' do
    let(:admin) { FactoryGirl.create(:user) }

    before do
      sign_in admin
    end

    describe 'GET #index' do

      it 'loads all the questions' do
        get :index
        expect(response).to be_success
        expect(assigns[:questions]).to eq(Question.all)
      end
    end

    describe 'GET #edit' do
      it "loads a question's form" do
        get :edit, id: question.id
        expect(response).to be_success
        expect(assigns[:question]).to eq(question)
      end
    end

    describe 'GET #new' do
      it "loads a question's form" do
        get :new
        expect(response).to be_success
        expect(assigns[:question]).to be_new_record
      end
    end

    describe 'PUT #update' do
      it 'updates a question' do
        post :update, id: question.id, question: { short: 'Huh?' }
        question.reload
        expect(question.short).to eq('Huh?')
        expect(response).to redirect_to(questions_path)
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes a question' do
        expect {
          delete :destroy, id: question.id
        }.to change(Question, :count).by(-1)
        expect(response).to redirect_to(questions_path)
      end
    end

    describe 'POST #create' do
      it 'creates a question' do
        expect {
          post :create, question: { short: 'Should foo?', long: 'Should foo really?' }
        }.to change(Question, :count).by(1)
        expect(response).to redirect_to(questions_path)
      end
    end
  end
end
