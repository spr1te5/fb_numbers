require 'numbers_finder/version'

module NumbersFinder
  class Error < StandardError; end

  extend self

  # Извлекает из потока текста максимальные целые числа длиной не более заданного значения.
  # == Параметры:
  # str:: поток с текстовыми данными.
  # max_numbers:: количество максимальных чисел.
  # max_number_len:: максимальная длина числа в символах.
  # == Результат:
  # отсортированый по возрастанию массив, содержащий максимальные целые числа.
  def extract_maximum_numbers_from_string str, max_numbers, max_number_len
    result = []

    extract_numbers_from_stream(str, max_numbers, max_number_len) { |number| 
      result.sort! { |num1, num2| num1 <=> num2 }  
      if result.size < max_numbers
        result << number
      else
         if !result.include?(number) && result.any? { |number_as_string| number_as_string < number }
           result[0..-2] = result[1..-1]
           result[-1] = number
        end
      end
    }

    result.map(&:to_i)
  end

  # :nodoc:
  def extract_numbers_from_stream str, max_numbers, max_number_len 
    last_number = ''
    str.each_char
       .lazy
       .each { |ch|
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
