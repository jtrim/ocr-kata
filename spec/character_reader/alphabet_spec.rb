require 'spec_helper'

RSpec.describe CharacterReader::Alphabet do
  describe '::readable_character_for' do
    subject { described_class }

    it 'is aliased as ::c' do
      expect(subject.method(:ocr_character_for)).to eq subject.method(:c)
    end
  end
end
