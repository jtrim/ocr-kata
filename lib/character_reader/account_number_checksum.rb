class CharacterReader::AccountNumberChecksum
  def initialize(account_number)
    @account_number = account_number.to_s
    @checksum = calculate_checksum(account_number)
  end

  def valid?
    checksum % 11 == 0
  end

  private

  attr_reader :checksum

  def calculate_checksum(account_number)
    account_number.split(//).map(&:to_i).reverse.map.with_index { |digit, i|
      modifier = i + 1
      digit * modifier
    }.reduce(:+)
  end
end
