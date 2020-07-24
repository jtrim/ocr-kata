class CharacterReader::DocumentReader
  class << self
    OPERATIONS = {
      strip_newlines: ->(s) { s.sub("\n", '') },
      explode_to_single_characters: ->(s) { s.split(//) },
      group_in_threes: ->(arr) { arr.each_slice(3).map(&:join) },
      join_ocr_character_lines: ->(lines) { lines.map { |l| "#{l}\n" }.join },
      get_char: ->(ocr_char) { CharacterReader::Alphabet.char_for(ocr_char) || "?" },
      drop_leading_newline: ->(s) { s.sub(/^\n/, '') }
    }

    def strip_newlines
      OPERATIONS[:strip_newlines]
    end

    def explode_to_single_characters
      OPERATIONS[:explode_to_single_characters]
    end

    def group_in_threes
      OPERATIONS[:group_in_threes]
    end

    def join_ocr_character_lines
      OPERATIONS[:join_ocr_character_lines]
    end

    def get_char
      OPERATIONS[:get_char]
    end

    def drop_leading_newline
      OPERATIONS[:drop_leading_newline]
    end

    def read(input_document)
      ocr_numbers = input_document.split(/^\s*$/).map(&drop_leading_newline)

      ocr_numbers.map do |ocr_number|
        characters_by_lines = ocr_number.lines.lazy
                                .map(&strip_newlines)
                                .map(&explode_to_single_characters)
                                .map(&group_in_threes)
                                .force.transpose

        ocr_characters = characters_by_lines.map(&join_ocr_character_lines)
        ocr_characters.map(&get_char).join
      end.join("\n")
    end
  end
end
