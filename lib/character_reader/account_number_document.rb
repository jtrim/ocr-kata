class CharacterReader::AccountNumberDocument
  def initialize(input_string)
    @input_string = input_string
    @parsed_account_numbers = CharacterReader::DocumentReader.read(input_string).split("\n")
  end

  def all_account_numbers
    parsed_account_numbers
  end

  def valid_account_numbers
    all_account_numbers.reject { |n| n.include?("?") }.select do |account_number|
      account_number.size == 9 &&
        valid_checksum?(account_number)
    end
  end

  def invalid_account_numbers
    (all_account_numbers - valid_account_numbers).map do |n|
      reason = if n.size < 9 || n.include?("?")
                 "ILL"
               else
                 "ERR"
               end
      [n, reason]
    end
  end

  private

  attr_reader :parsed_account_numbers

  def valid_checksum?(account_number)
    CharacterReader::AccountNumberChecksum.new(account_number).valid?
  end
end
