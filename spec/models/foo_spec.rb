require 'rails_helper'

RSpec.describe Foo, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:bars) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:foo)).to be_valid
    end
  end
end