# rubocop: disable Layout/LineLength, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Naming/ConstantName
# lib/linter_errors_rb

require_relative '../lib/file_reader'
class Linter < ParseFile
  attr_reader :file_data

  Keywords = %w[def class if module while until until for switch times].freeze
  Endline = 'end'
  def check_errors
    line_length
    missing_ends
    identation
    trailing_whitespace
    missing_endline
    brackets_whitespace
  end

  def missing_ends
    count = 0
    test_count = 0
    take_line = 0
    error_line = 0
    for x in file_data
      next if x.include?('#')

      for y in Keywords
        count += 1 if x.include?(y)
      end
    end
    file_data.each { |n| test_count += 1 if n.match(Endline) }
    for x in file_data
      take_line += 1
      error_line = take_line if x.match(Endline)
    end
    if count > test_count
      puts "Missing end on line #{error_line}"
      error5 = "Missing end on line #{error_line}"
    end
    puts "Unnecessary end on line #{error_line}" if count < test_count
    error5
  end

  def identation
    line_num = 0
    current_ident = 0
    next_ident = 0
    got_ident = 0
    for x in file_data
      splited_line = x.split('')
      line_num += 1
      next if x.include?('#')

      for y in Keywords
        if x.include?(y)
          next_ident += 2
          next
        end
      end
      if x.include?(Endline)
        next_ident -= 2
        current_ident = next_ident
      end
      splited_line.each { |n| n == ' ' ? got_ident += 1 : break }
      if current_ident != got_ident
        puts "Wrong identation on line #{line_num + 1} expected #{current_ident} got #{got_ident}" unless current_ident.negative?
        error4 = "Wrong identation on line #{line_num + 1} expected #{current_ident} got #{got_ident}"
      end
      current_ident = next_ident
      got_ident = 0
    end
    error4
  end

  def trailing_whitespace
    line_num = 0
    for x in file_data
      line_num += 1
      splited_line = x.split('')
      if splited_line.reverse[1] == ' '
        puts "Trailing white-space on line #{line_num}"
        error3 = "Trailing white-space on line #{line_num}"
      end
    end
    error3
  end

  def missing_endline
    unless file_data.last.match(/\s/)
      puts 'Missing final endline'
      error6 = 'Missing final endline'
    end
    error6
  end

  def brackets_whitespace
    line_num = 0
    for x in file_data
      splited_line = x.split('')
      line_num += 1
      index = 0
      while index < splited_line.length
        if splited_line[index] == '{' and splited_line[index + 1] != ' '
          puts "Missing white-space after { on line #{line_num}"
          error2 = "Missing white-space after { on line #{line_num}"
        end
        if splited_line[index] == '}' and splited_line[index - 1] != ' '
          puts "Missing white-space before } on line #{line_num}"
        end
        if splited_line[index] == ',' and splited_line[index + 1] != ' '
          puts "Missing white-space after , on line #{line_num}"
        end
        index += 1
      end
    end
    error2
  end

  def line_length
    line_num = 0
    for x in file_data
      line_num += 1
      if x.length > 80
        puts "Line #{line_num} too long #{x.length}/80"
        error1 = "Line #{line_num} too long #{x.length}/80"
      end
    end
    error1
  end
end
# rubocop: enable Layout/LineLength, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Naming/ConstantName
