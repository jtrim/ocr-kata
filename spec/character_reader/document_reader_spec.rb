require 'spec_helper'

RSpec.describe CharacterReader::DocumentReader do
  subject { described_class }

  describe "::read" do
    it "can parse a simple input document" do
      expect(subject.read(
               " _ \n" +
               "| |\n" +
               "|_|\n")).to eq "0"
    end

    it "can parse a complex input document" do
      expect(subject.read(
               " _     _  _ \n" +
               "| |  | _| _|\n" +
               "|_|  ||_  _|\n")).to eq "0123"
    end

    describe "blank line handling" do
      it "correctly parses lines of OCR data into lines of char data" do
        expect(subject.read(
                 " _     _  _ \n" \
                 "| |  | _| _|\n" \
                 "|_|  ||_  _|\n" \
                 "\n" \
                 "    _  _ \n" \
                 "|_||_ |_ \n" \
                 "  | _||_|\n"
               )).to eq "0123\n456"
      end

      it "isn't confused by blank lines with spaces in them" do
        expect(subject.read(
                 " _     _  _ \n" \
                 "| |  | _| _|\n" \
                 "|_|  ||_  _|\n" \
                 "  \n" \
                 "    _  _ \n" \
                 "|_||_ |_ \n" \
                 "  | _||_|\n"
               )).to eq "0123\n456"
      end

      it "consolidates consecutive blank lines into one" do
        expect(subject.read(
                 " _     _  _ \n" \
                 "| |  | _| _|\n" \
                 "|_|  ||_  _|\n" \
                 "  \n" \
                 "  \n" \
                 "    _  _ \n" \
                 "|_||_ |_ \n" \
                 "  | _||_|\n"
               )).to eq "0123\n456"
      end
    end
  end
end
