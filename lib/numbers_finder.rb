require 'numbers_finder/version'

module NumbersFinder
  extend self
  
  class Error < StandardError; end

  class StdInChunksSource
    attr_accessor :chunk_size

    def initialize(size = 4096)
      self.chunk_size = size
    end

    def each_char
      begin
        loop do
          STDIN.read_nonblock(chunk_size).each_char { |char| yield(char) }
        end
      rescue
      end
    end
  end

  class StringChunksSource
    attr_accessor :string
    
    def initialize(string)
      self.string = string
    end

    def each_char
      string.each_char { |ch| yield(ch) }
    end
  end

  # Извлекает из источника текста максимальные целые числа длиной не более заданного значения.
  # == Параметры:
  # max_numbers:: количество максимальных чисел.
  # max_number_len:: максимальная длина числа в символах.
  # source:: поток с текстовыми данными (по умолчанию - STDIN).  
  # == Результат:
  # отсортированый по возрастанию массив, содержащий максимальные целые числа.
  def extract_maximum_numbers_from_stream(max_numbers, max_number_len, source = StdInChunksSource.new)
    result = []

    scan_chunks_for_numbers(source, max_numbers, max_number_len) { |number| 
      result.sort! { |num1, num2| num1 <=> num2 }

      not_added = !result.include?(number)
      if result.size < max_numbers && not_added
        result << number
      else
         if not_added && result.any? { |number_as_string| number_as_string < number }
           result[0..-2] = result[1..-1]
           result[-1] = number
        end
      end
    }

    result.map(&:to_i)
  end

  # :nodoc:
  def scan_chunks_for_numbers(source, max_numbers, max_number_len)
    last_number = ''
    source.each_char { |ch|
      catch_number = false

      if ch =~ /[0-9]/
        last_number << ch
        catch_number = true if last_number.length == max_number_len
      elsif last_number.length > 0
        catch_number = true
      end

      if catch_number
        yield "%0#{max_number_len}d" % last_number
        last_number = ''
      end
    }

    #The last symbol is a digit  
    if last_number.length > 0
      yield "%0#{max_number_len}d" % last_number
    end
  end
end
