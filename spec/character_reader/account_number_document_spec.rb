require 'spec_helper'

RSpec.describe CharacterReader::AccountNumberDocument do
  let(:document) do
    "    _  _     _  _  _  _  _ \n" \
    "  | _| _||_||_ |_   ||_||_|\n" \
    "  ||_  _|  | _||_|  ||_| _|\n" \
    "\n" \
    " _  _  _     _  _  _  _    \n" \
    " _| _||_||_||_||_   ||_|  |\n" \
    "|_ |_ |_|  | _| _|  ||_|  |\n" \
    "\n" \
    "          _  _  _  _  _  _ \n" \
    "  |  |  | _| _| _| _| _| _|\n" \
    "  |  |  ||_ |_ |_  _| _| _|\n" \
    "\n" \
    "    _  _     _  _  _  _ \n" \
    "  | _| _||_||_ |_   ||_|\n" \
    "  ||_  _|  | _||_|  ||_|\n" \
    "\n" \
    " _     _  _  _  _  _  _  _ \n" \
    " _||_||_ |_||_| _||_||_ |_ \n" \
    " _|  | _||_||_||_ |_||_| _|\n"
  end

  let(:valid_account_numbers) do
    [
      "123456789",
      "228495781",
      "345882865"
    ]
  end

  subject { described_class.new(document) }

  before do
    valid_checksum = instance_double(CharacterReader::AccountNumberChecksum, valid?: true)
    invalid_checksum = instance_double(CharacterReader::AccountNumberChecksum, valid?: false)

    allow(CharacterReader::AccountNumberChecksum).to receive(:new).with(instance_of(String)).and_return(invalid_checksum)
    (valid_account_numbers + ["12345678"]).each do |n|
      allow(CharacterReader::AccountNumberChecksum).to receive(:new).with(n).and_return(valid_checksum)
    end
  end

  describe "#all_account_numbers" do
    it 'parses a document of account numbers separated by a blank line' do
      expect(subject.all_account_numbers).to eq ["123456789", "228495781", "111222333", "12345678", "345882865"]
    end
  end

  describe "#valid_account_numbers" do
    it "ensures account numbers are 9 digits long and pass the checksum validation" do
      expect(subject.valid_account_numbers).to eq valid_account_numbers
    end
  end
end
