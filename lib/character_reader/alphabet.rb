module CharacterReader
  module Alphabet
    UnknownCharacterError = RuntimeError

    OCR_CHARACTER_BY_CHAR = {
      "0" => " _ \n" \
             "| |\n" \
             "|_|\n",

      "1" => "   \n" \
             "  |\n" \
             "  |\n",

      "2" => " _ \n" \
             " _|\n" \
             "|_ \n",

      "3" => " _ \n" \
             " _|\n" \
             " _|\n",

      "4" => "   \n" \
             "|_|\n" \
             "  |\n",

      "5" => " _ \n" \
             "|_ \n" \
             " _|\n",

      "6" => " _ \n" \
             "|_ \n" \
             "|_|\n",

      "7" => " _ \n" \
             "  |\n" \
             "  |\n",

      "8" => " _ \n" \
             "|_|\n" \
             "|_|\n",

      "9" => " _ \n" \
             "|_|\n" \
             " _|\n",
    }.freeze

    def self.ocr_character_for(char)
      OCR_CHARACTER_BY_CHAR[char.to_s] || raise(UnknownCharacterError, "Unknown character #{char.inspect}")
    end
    class << self
      alias c ocr_character_for
    end

    def self.char_for(ocr_character)
      @reverse_lookup_dictionary ||= OCR_CHARACTER_BY_CHAR.invert
      @reverse_lookup_dictionary[ocr_character]
    end
  end
end
