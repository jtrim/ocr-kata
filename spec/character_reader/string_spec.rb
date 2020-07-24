require 'spec_helper'

RSpec.describe CharacterReader::String do
  describe "::create" do
    subject { described_class }

    it 'creates a visual string from a given input string' do
      expect(subject.create('0').to_s).to eq(
                                            " _ \n" +
                                            "| |\n" +
                                            "|_|\n")

      expect(subject.create('01').to_s).to eq(
                                             " _    \n" +
                                             "| |  |\n" +
                                             "|_|  |\n")

      expect(subject.create('0123456789').to_s).to eq(
                                                     " _     _  _     _  _  _  _  _ \n" +
                                                     "| |  | _| _||_||_ |_   ||_||_|\n" +
                                                     "|_|  ||_  _|  | _||_|  ||_| _|\n")
    end
  end

  describe "#+" do
    let(:left) { described_class.new(CharacterReader::Alphabet.c(0)) }
    let(:right) { described_class.new(CharacterReader::Alphabet.c(1)) }

    it 'joins the character data into a readable format' do
      expect((left + right).to_s).to eq(
                                       " _    \n" +
                                       "| |  |\n" +
                                       "|_|  |\n")
    end

    it 'returns an instance of the same class' do
      expect(left + right).to be_instance_of(described_class)
    end

    context 'with complex strings' do
      it 'joins two strings with multiple characters' do
        left = described_class.new(
          " _    \n" +
          "| |  |\n" +
          "|_|  |\n")

        right = described_class.new(
          " _  _ \n" +
          " _| _|\n" +
          "|_  _|\n")

        expect((left + right).to_s).to eq(
                                         " _     _  _ \n" +
                                         "| |  | _| _|\n" +
                                         "|_|  ||_  _|\n")
      end
    end
  end

  describe "#to_s" do
    it "prints the visual character data" do
      expect(described_class.new(CharacterReader::Alphabet.c(0)).to_s)
        .to eq(
              " _ \n" +
              "| |\n" +
              "|_|\n")
    end
  end
end
