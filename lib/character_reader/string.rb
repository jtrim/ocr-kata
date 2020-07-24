class CharacterReader::String
  def self.create(input_string)
    new input_string.split(//).map { |c| new CharacterReader::Alphabet.c(c) }.reduce(:+).to_s
  end

  def initialize(visual_char_data)
    @visual_char_data = visual_char_data
  end

  def to_s
    visual_char_data
  end

  def +(other_s)
    self.class.new(
      to_s.lines.zip(other_s.to_s.lines).map { |(left, right)| left.sub("\n", "") + right }.join
    )
  end

  private

  attr_reader :visual_char_data
end
