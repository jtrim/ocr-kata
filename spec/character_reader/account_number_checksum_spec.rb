require 'spec_helper'

RSpec.describe CharacterReader::AccountNumberChecksum do
  describe '#valid?' do
    it 'returns true for a valid account number' do
      expect(described_class.new("345882865").valid?).to be true
    end

    it 'returns false for an invalid account number' do
      expect(described_class.new("228495781").valid?).to be false
    end
  end
end
