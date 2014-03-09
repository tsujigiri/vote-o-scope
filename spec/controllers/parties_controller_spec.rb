require 'spec_helper'

describe PartiesController do
  render_views

  let!(:party) { FactoryGirl.create(:party) }

  context 'as an admin' do
    let(:admin) { FactoryGirl.create(:user) }

    before do
      sign_in admin
    end

    describe 'GET #index' do

      it 'loads all the parties' do
        get :index
        expect(response).to be_success
        expect(assigns[:parties]).to eq(Party.all)
      end
    end

    describe 'GET #edit' do
      it "loads a party's form" do
        get :edit, id: party.id
        expect(response).to be_success
        expect(assigns[:party]).to eq(party)
      end
    end

    describe 'GET #new' do
      it "loads a party's form" do
        get :new
        expect(response).to be_success
        expect(assigns[:party]).to be_new_record
      end
    end

    describe 'PUT #update' do
      it 'updates a party' do
        post :update, id: party.id, party: { name: 'XYZ' }
        party.reload
        expect(party.name).to eq('XYZ')
        expect(response).to redirect_to(parties_path)
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes a party' do
        expect {
          delete :destroy, id: party.id
        }.to change(Party, :count).by(-1)
        expect(response).to redirect_to(parties_path)
      end
    end
  end
end
