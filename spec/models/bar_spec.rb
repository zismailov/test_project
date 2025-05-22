require 'rails_helper'

RSpec.describe Bar, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should belong_to(:foo) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:bar)).to be_valid
    end
  end
end