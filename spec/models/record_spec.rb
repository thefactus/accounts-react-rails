require 'rails_helper'

describe Record do
  let(:record) { FactoryGirl.create :record }

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :date }
    it { should validate_presence_of :amount }
  end
end
