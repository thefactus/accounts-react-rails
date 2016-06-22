require 'rails_helper'

describe RecordsController do
  describe 'POST #create' do
    context 'when is successfully created' do
      before(:each) do
        @record_attributes = FactoryGirl.attributes_for(:record)
        post :create,
             { record: @record_attributes },
             format: :json
      end

      it 'renders the json representaion for the record just created' do
        expect(json_response).to include @record_attributes
      end

      it { should respond_with 201 }
    end

    context 'when is not created' do
      before(:each) do
        @invalid_user_attributes = { title: nil, amount: nil, date: nil }
        post :create,
             { record: @invalid_user_attributes },
             format: :json
      end

      it 'renders an errors json' do
        expect(json_response).to have_key(:errors)
      end

      it 'renders the json errors when the record could not be created' do
        expect(json_response[:errors][:title]).to include "can't be blank"
        expect(json_response[:errors][:amount]).to include "can't be blank"
        expect(json_response[:errors][:date]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe 'PUT/PATCH #update' do
    before(:each) do
      @record = FactoryGirl.create(:record)
    end

    context 'when record is successfully updated' do
      before(:each) do
        patch :update,
              { id: @record.id, record: { title: 'New updated title' } },
              format: :json
      end

      it 'renders the json representation for the updated user' do
        expect(json_response[:title]).to eq('New updated title')
      end

      it { should respond_with 200 }
    end

    context 'when record is not updated' do
      before(:each) do
        patch :update,
              { id: @record.id, record: { title: '' } },
              format: :json
      end

      it 'renders an errors json' do
        expect(json_response).to have_key(:errors)
      end

      it 'renders the json errors when the record could not be updated' do
        expect(json_response[:errors][:title]).to include("can't be blank")
      end

      it { should respond_with 422 }
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @record = FactoryGirl.create(:record)
      delete :destroy,
             { id: @record.id },
             format: :json
    end

    it { should respond_with 204 }
  end
end
